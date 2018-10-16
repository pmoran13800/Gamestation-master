################################################################################
#
# gamestation-romfs-apple2
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system apple2 --extension '.nib .NIB .do .DO .po .PO .dsk .DSK' --fullname 'Apple II' --platform apple2 --theme apple2 BR2_PACKAGE_LINAPPLE_PIE

# Name the 3 vars as the package requires
GAMESTATION_ROMFS_APPLE2_SOURCE = 
GAMESTATION_ROMFS_APPLE2_SITE = 
GAMESTATION_ROMFS_APPLE2_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_APPLE2 = apple2
SYSTEM_XML_APPLE2 = $(@D)/$(SYSTEM_NAME_APPLE2).xml
# System rom path
SOURCE_ROMDIR_APPLE2 = $(GAMESTATION_ROMFS_APPLE2_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in gamestation-romfs, so take good care that
# variables are global across buildroot


ifeq ($(BR2_PACKAGE_LINAPPLE_PIE),y)
define CONFIGURE_APPLE2
	$(call GAMESTATION_ROMFS_CALL_ADD_STANDALONE_SYSTEM,$(SYSTEM_XML_APPLE2),Apple II,$(SYSTEM_NAME_APPLE2),.nib .NIB .do .DO .po .PO .dsk .DSK,apple2,apple2,$(SOURCE_ROMDIR_APPLE2),$(@D))
endef
GAMESTATION_ROMFS_APPLE2_CONFIGURE_CMDS += $(CONFIGURE_APPLE2)
endif

$(eval $(generic-package))
