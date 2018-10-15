#!/bin/bash

system_settings=/gamestation/share/system/gamestation.conf

command="$1"
argsetting="$2"
log=/gamestation/share/system/logs/gamestation.log

if [[ "$command" == "get" ]];then
	echo "`logtime` : systemsetting.sh - searching for $argsetting" >> $log
	setting=`cat "$system_settings" | sed -n "s/^${argsetting}=\(.*\)/\1/p"`
	if [[ "$?" != "0" ]]; then
		exit 1
	fi
	if [[ "$setting" != "" ]]; then
		echo "`logtime` : systemsetting.sh - $argsetting found : $setting" >> $log
		echo $setting
		exit 0
	fi
fi
exit 1

