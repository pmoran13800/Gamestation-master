################################################################################
#
# gamestation-romfs-wii
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system wii --extension '.iso .ISO .wbfs .WBFS' --fullname 'Wii' --platform wii --theme wii BR2_PACKAGE_DOLPHIN_EMU

# Name the 3 vars as the package requires
GAMESTATION_ROMFS_WII_SOURCE = 
GAMESTATION_ROMFS_WII_SITE = 
GAMESTATION_ROMFS_WII_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_WII = wii
SYSTEM_XML_WII = $(@D)/$(SYSTEM_NAME_WII).xml
# System rom path
SOURCE_ROMDIR_WII = $(GAMESTATION_ROMFS_WII_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in gamestation-romfs, so take good care that
# variables are global across buildroot


ifeq ($(BR2_PACKAGE_DOLPHIN_EMU),y)
define CONFIGURE_WII
	$(call GAMESTATION_ROMFS_CALL_ADD_STANDALONE_SYSTEM,$(SYSTEM_XML_WII),Wii,$(SYSTEM_NAME_WII),.iso .ISO .wbfs .WBFS,wii,wii,$(SOURCE_ROMDIR_WII),$(@D))
endef
GAMESTATION_ROMFS_WII_CONFIGURE_CMDS += $(CONFIGURE_WII)
endif

$(eval $(generic-package))
