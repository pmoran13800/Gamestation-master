#!/bin/bash

upGradeToGamestationNextTheme() {
    tmpFile=/tmp/es_setting.cfg.tmp
    # Set theme as gamestation-next + get default values from the share_init version
    # 1st rename ThemeSet value to gamestation-next
    # 2nd remove the last tag
    # 3rd add the required lines from the share_init version
    # close XML
    ( \
	sed 's+name="ThemeSet" value="gamestation"+name="ThemeSet" value="gamestation-next"+' /gamestation/share/system/.emulationstation/es_settings.cfg | \
        sed '/<\/config>/d' ; \
        grep -E 'name="ThemeMenu|ThemeSystemView|ThemeIconSet|ThemeGamelistView|ThemeColorSet"' /gamestation/share_init/system/.emulationstation/es_settings.cfg ; \
        echo "</config>"
    ) | xmllint --format - > $tmpFile

    # If all of this has succeeded, itmeans the resulting file is valid and we can upgrade the user file
    if [[ $? == 0 ]] ; then
        cp $tmpFile /gamestation/share/system/.emulationstation/es_settings.cfg
        return 0
    fi
    return 1
}

if grep -q 'name="ThemeSet" value="gamestation"' /gamestation/share/system/.emulationstation/es_settings.cfg ; then
    recallog "Upgrading theme to gamestation-next"
    upGradeToGamestationNextTheme && recallog "gamestation-next Succeeded !" || recallog "gamestation-next failed !"
fi
