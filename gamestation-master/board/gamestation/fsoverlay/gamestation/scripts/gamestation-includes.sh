#!/bin/bash

#
## This is a kind of header file that can be used to declare variables and functions
## That could turn useful in any gamestation script
#

#
## Variables
#

_RBX=/gamestation
_SHAREINIT=$_RBX/share_init
_SHARE=$_RBX/share

#
## Functions
#
function shouldUpdate {
  rbxVersion=$_RBX/gamestation.version
  curVersion=$_SHARE/system/logs/lastgamestation.conf.update
  diff -qN "$curVersion" "$rbxVersion" 2>/dev/null && return 1
  return 0
}
# Checks if $1 exists in the array passed for $2
function containsElement {
  # local e
  # for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  [[ "${@:2}" =~ "$1" ]] && return 0
  return 1
}

function doGamestationUpgrades {
  if ! shouldUpdate;then 
    recallog -e "No need to upgrade configuration files" && return 0
  fi
  doRbxConfUpgrade
  upgradeConfiggen
  upgradeInputs
  upgradeTheme
}

# Upgrade the gamestation.conf if necessary
function doRbxConfUpgrade {
  # Update gamestation.conf
  rbxVersion=$_RBX/gamestation.version
  curVersion=$_SHARE/system/logs/lastgamestation.conf.update
  
  # Check if an update is necessary
  if ! shouldUpdate;then 
    recallog -e "gamestation.conf already up-to-date" && return 0
  fi 
  cfgIn=$_SHAREINIT/system/gamestation.conf
  cfgOut=$_SHARE/system/gamestation.conf
  forced=(controllers.ps3.driver) # Used as a regex, need to escape .
  savefile=${cfgOut}-pre-$(cat $rbxVersion | sed "s+[/ :]++g")
  tmpFile=/tmp/gamestation.conf

  recallog -e "UPDATE : gamestation.conf to $(cat $rbxVersion)"
  cp $cfgIn $tmpFile || { recallog -e "ERROR : Couldn't copy $cfgIn to $tmpFile" ; return 1 ; }
  
  while read -r line ; do
    name=`echo $line | cut -d '=' -f 1`
    value=`echo $line | cut -d '=' -f 2-`
    # echo "$name => $value"
    # Don't update forced values
    if containsElement $name $forced ; then
      recallog "FORCING : $name=$value"
      continue
    fi

    # Check if the property exists or has to be added
    if grep -qE "^[;]?$name=" $cfgIn; then
      recallog "ADDING user defined to $cfgOut : $name=$value"
      sed -i s$'\001'"^[;]\?$name=.*"$'\001'"$name=$value"$'\001' $tmpFile || { recallog "ERROR : Couldn't replace $name=$value in $tmpFile" ; return 1 ; }
    else
      recallog "ADDING custom property to $cfgOut : $name=$value"
      echo "$name=$value" >> $tmpFile || { recallog "ERROR : Couldn't write $name=$value in $tmpFile" ; return 1 ; }
    fi

  done < <(grep -E "^[[:alnum:]\-]+\.[[:alnum:].\-]+=[[:print:]]+$" $cfgOut)
  
  cp $cfgOut $savefile || { recallog -e "ERROR : Couldn't backup $cfgOut to $savefile" ; return 1 ; }
  rm -f $cfgOut
  mv $tmpFile $cfgOut || { recallog -e "ERROR : Couldn't apply the new gamestation.conf" ; return 1 ; }
  cp "$rbxVersion" "$curVersion" || { recallog -e "ERROR : Couldn't set the new gamestation.conf version" ; return 1 ; }
  recallog "UPDATE done !"
}

function upgradeConfiggen {
  
  NEW_VERSION=$(sed -rn "s/^\s*([0-9a-zA-Z.]*)\s*.*$/\1/p" /gamestation/gamestation.version)
  python -c "import sys; sys.path.append('/usr/lib/python2.7/site-packages/configgen'); from emulatorlauncher import config_upgrade; config_upgrade('$NEW_VERSION')"
}

function upgradeInputs {
  /gamestation/scripts/gamestation-config.sh updateesinput "Microsoft X-Box 360 pad" "030000005e0400008e02000014010000"
  /gamestation/scripts/gamestation-config.sh updateesinput "Xbox 360 Wireless Receiver (XBOX)" "030000005e040000a102000007010000"
  /gamestation/scripts/gamestation-config.sh updateesinput "Xbox 360 Wireless Receiver" "030000005e0400001907000000010000"
}

function upgradeTheme {
  /gamestation/scripts/gamestation-themes.sh
}

function upgradeRetroarchCoreNames {
  OUTPUT=/gamestation/system/resources/retroarch.corenames
  [[ "$1" == "-f" ]] && OUTPUT="$2"
  rm "$OUTPUT" 2>/dev/null

  for file in /usr/lib/libretro/*.so ; do
    rbxsystem=`basename $file | sed -E "s%(.*)_libretro.so%\1%"`
    coreinfos=`/usr/bin/nanoarch $file 2>/dev/null`
    coreName=`echo $coreinfos | cut -d ';' -f 1`
    coreVersion=`echo $coreinfos | cut -d ';' -f 2`
    echo "$coreName;$rbxsystem;$coreVersion" >> "$OUTPUT"
  done
}
