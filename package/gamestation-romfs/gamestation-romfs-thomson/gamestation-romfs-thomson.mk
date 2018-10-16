################################################################################
#
# gamestation-romfs-thomson
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system thomson --extension '.fd .FD .sap .SAP .k7 .K7 .m7 .M7 .rom .ROM .zip .ZIP' --fullname 'Thomson' --platform thomsonto --theme to8 libretro:theodore:BR2_PACKAGE_LIBRETRO_THEODORE

# Name the 3 vars as the package requires
GAMESTATION_ROMFS_THOMSON_SOURCE = 
GAMESTATION_ROMFS_THOMSON_SITE = 
GAMESTATION_ROMFS_THOMSON_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_THOMSON = thomson
SYSTEM_XML_THOMSON = $(@D)/$(SYSTEM_NAME_THOMSON).xml
# System rom path
SOURCE_ROMDIR_THOMSON = $(GAMESTATION_ROMFS_THOMSON_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in gamestation-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_THEODORE),)
define CONFIGURE_MAIN_THOMSON_START
	$(call GAMESTATION_ROMFS_CALL_ADD_SYSTEM,$(SYSTEM_XML_THOMSON),Thomson,$(SYSTEM_NAME_THOMSON),.fd .FD .sap .SAP .k7 .K7 .m7 .M7 .rom .ROM .zip .ZIP,thomsonto,to8)
endef

ifneq ($(BR2_PACKAGE_LIBRETRO_THEODORE),)
define CONFIGURE_THOMSON_LIBRETRO_START
	$(call GAMESTATION_ROMFS_CALL_START_EMULATOR,$(SYSTEM_XML_THOMSON),libretro)
endef
ifeq ($(BR2_PACKAGE_LIBRETRO_THEODORE),y)
define CONFIGURE_THOMSON_LIBRETRO_THEODORE_DEF
	$(call GAMESTATION_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_THOMSON),theodore)
endef
endif

define CONFIGURE_THOMSON_LIBRETRO_END
	$(call GAMESTATION_ROMFS_CALL_END_EMULATOR,$(SYSTEM_XML_THOMSON))
endef
endif



define CONFIGURE_MAIN_THOMSON_END
	$(call GAMESTATION_ROMFS_CALL_END_SYSTEM,$(SYSTEM_XML_THOMSON),$(SOURCE_ROMDIR_THOMSON),$(@D))
endef
endif

define GAMESTATION_ROMFS_THOMSON_CONFIGURE_CMDS
	$(CONFIGURE_MAIN_THOMSON_START)
	$(CONFIGURE_THOMSON_LIBRETRO_START)
	$(CONFIGURE_THOMSON_LIBRETRO_THEODORE_DEF)
	$(CONFIGURE_THOMSON_LIBRETRO_END)
	$(CONFIGURE_MAIN_THOMSON_END)
endef

$(eval $(generic-package))
