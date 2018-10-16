################################################################################
#
# Gamestation themes for EmulationStation : https://gitlab.com/gamestation/gamestation-themes
#
################################################################################

GAMESTATION_THEMES_VERSION = 6b5cae427e7a0b7cf14aca694bedcb0429b33a40
GAMESTATION_THEMES_SITE = https://gitlab.com/gamestation/gamestation-themes.git
GAMESTATION_THEMES_SITE_METHOD = git

define GAMESTATION_THEMES_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/gamestation/share_init/system/.emulationstation/themes/
	cp -r $(@D)/themes/gamestation-next \
		$(TARGET_DIR)/gamestation/share_init/system/.emulationstation/themes/
endef

$(eval $(generic-package))
