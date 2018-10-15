#!/bin/bash -e


COMMAND="$1"

if [[ -z ${COMMAND} ]]; then
  echo -e "Usage:\n$0 COMMAND" && exit 1
fi


BINDIR="${BINDIR:-/gamestation/scripts/upgrade/}"
SYSTEMSETTINGS="python /usr/lib/python2.7/site-packages/configgen/settings/gamestationSettings.pyc"
GAMESTATION_SYSTEM_DIR="/gamestation/share/system"
INSTALLED_VERSION=$(cat /gamestation/gamestation.version)
ARCH=$(cat /gamestation/gamestation.arch)
UPGRADETYPE="$($SYSTEMSETTINGS  -command load -key updates.type)"

SERVICE_URL="https://recaleur-archive-prod.gamestation.com:9443"

UUID=$("$BINDIR/../system/uuid.sh" --uuid-file "${GAMESTATION_SYSTEM_DIR}/uuid")

if [[ "${UPGRADETYPE}" == "beta" || "${UPGRADETYPE}" == "unstable" ]]; then
  UPGRADETYPE="stable"
fi


## COMMANDS
if [ "${COMMAND}" == "canupgrade" ];then
  if [[ "${UPGRADETYPE}" == "stable" ]]; then
    "$BINDIR/gamestation-canupgrade.sh" --from-version "${INSTALLED_VERSION}" --service-url "${SERVICE_URL}" --arch "${ARCH}" --uuid "${UUID}"
    exit $?
  else
    "$BINDIR/gamestation-canupgrade-from-archive.sh" --from-version "${INSTALLED_VERSION}" --upgrade-url "${UPGRADETYPE}" --arch "${ARCH}"
    exit $?
  fi
  echo "no upgrade available"
  exit 12
fi

if [ "${COMMAND}" == "upgrade" ];then
  if [[ "${UPGRADETYPE}" == "stable" ]]; then
    UPGRADE_URL=$("$BINDIR/gamestation-canupgrade.sh" --from-version "${INSTALLED_VERSION}" --service-url "${SERVICE_URL}" --arch "${ARCH}" --uuid "${UUID}")
    [[ "$?" != "0" ]] && exit 1
  else
    UPGRADE_URL="${UPGRADETYPE}"
  fi
  "$BINDIR/gamestation-do-upgrade.sh" --upgrade-dir "${GAMESTATION_SYSTEM_DIR}/upgrade" --upgrade-url "${UPGRADE_URL}" --arch "${ARCH}" 2> "/tmp/gamestation.do.upgrade.log"
  exitcode="$?"
  cat "/tmp/gamestation.do.upgrade.log" | recallog
  exit "${exitcode}"
fi

if [ "${COMMAND}" == "diffremote" ];then
   if [[ "${UPGRADETYPE}" == "stable" ]]; then
    UPGRADE_URL=$("$BINDIR/gamestation-canupgrade.sh" --from-version "${INSTALLED_VERSION}" --service-url "${SERVICE_URL}" --arch "${ARCH}" --uuid "${UUID}")
    [[ "$?" != "0" ]] && exit 1
  else
    UPGRADE_URL="${UPGRADETYPE}"
  fi
  "$BINDIR/gamestation-upgrade-diff-remote.sh" --from-version "${INSTALLED_VERSION}" --upgrade-url "${UPGRADE_URL}" --arch "${ARCH}" --changelog "/gamestation/gamestation.changelog"
  exit $?
fi

if [ "${COMMAND}" == "difflocal" ];then
  "$BINDIR/gamestation-upgrade-diff-local.sh" --from-changelog "${GAMESTATION_SYSTEM_DIR}/gamestation.changelog.done" --to-changelog "/gamestation/gamestation.changelog"
  exit $?
fi



echo "command not found"
exit 20