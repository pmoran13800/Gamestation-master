################################################################################
#
# gamestation-romfs-gamecube
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system gamecube --extension '.iso .ISO .gc .GC .gcz .GCZ .gcm .GCM' --fullname 'GameCube' --platform gc --theme gc BR2_PACKAGE_DOLPHIN_EMU

# Name the 3 vars as the package requires
GAMESTATION_ROMFS_GAMECUBE_SOURCE = 
GAMESTATION_ROMFS_GAMECUBE_SITE = 
GAMESTATION_ROMFS_GAMECUBE_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_GAMECUBE = gamecube
SYSTEM_XML_GAMECUBE = $(@D)/$(SYSTEM_NAME_GAMECUBE).xml
# System rom path
SOURCE_ROMDIR_GAMECUBE = $(GAMESTATION_ROMFS_GAMECUBE_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in gamestation-romfs, so take good care that
# variables are global across buildroot


ifeq ($(BR2_PACKAGE_DOLPHIN_EMU),y)
define CONFIGURE_GAMECUBE
	$(call GAMESTATION_ROMFS_CALL_ADD_STANDALONE_SYSTEM,$(SYSTEM_XML_GAMECUBE),GameCube,$(SYSTEM_NAME_GAMECUBE),.iso .ISO .gc .GC .gcz .GCZ .gcm .GCM,gc,gc,$(SOURCE_ROMDIR_GAMECUBE),$(@D))
endef
GAMESTATION_ROMFS_GAMECUBE_CONFIGURE_CMDS += $(CONFIGURE_GAMECUBE)
endif

$(eval $(generic-package))
