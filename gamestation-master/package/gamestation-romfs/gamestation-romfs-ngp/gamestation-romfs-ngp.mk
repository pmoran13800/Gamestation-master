################################################################################
#
# gamestation-romfs-ngp
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system ngp --extension '.zip .ZIP .ngc .NGC .ngp .NGP' --fullname 'Neo-Geo Pocket' --platform ngp --theme ngp libretro:mednafen_ngp:BR2_PACKAGE_LIBRETRO_BEETLE_NGP

# Name the 3 vars as the package requires
GAMESTATION_ROMFS_NGP_SOURCE = 
GAMESTATION_ROMFS_NGP_SITE = 
GAMESTATION_ROMFS_NGP_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_NGP = ngp
SYSTEM_XML_NGP = $(@D)/$(SYSTEM_NAME_NGP).xml
# System rom path
SOURCE_ROMDIR_NGP = $(GAMESTATION_ROMFS_NGP_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in gamestation-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_NGP),)
define CONFIGURE_MAIN_NGP_START
	$(call GAMESTATION_ROMFS_CALL_ADD_SYSTEM,$(SYSTEM_XML_NGP),Neo-Geo Pocket,$(SYSTEM_NAME_NGP),.zip .ZIP .ngc .NGC .ngp .NGP,ngp,ngp)
endef

ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_NGP),)
define CONFIGURE_NGP_LIBRETRO_START
	$(call GAMESTATION_ROMFS_CALL_START_EMULATOR,$(SYSTEM_XML_NGP),libretro)
endef
ifeq ($(BR2_PACKAGE_LIBRETRO_BEETLE_NGP),y)
define CONFIGURE_NGP_LIBRETRO_MEDNAFEN_NGP_DEF
	$(call GAMESTATION_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_NGP),mednafen_ngp)
endef
endif

define CONFIGURE_NGP_LIBRETRO_END
	$(call GAMESTATION_ROMFS_CALL_END_EMULATOR,$(SYSTEM_XML_NGP))
endef
endif



define CONFIGURE_MAIN_NGP_END
	$(call GAMESTATION_ROMFS_CALL_END_SYSTEM,$(SYSTEM_XML_NGP),$(SOURCE_ROMDIR_NGP),$(@D))
endef
endif

define GAMESTATION_ROMFS_NGP_CONFIGURE_CMDS
	$(CONFIGURE_MAIN_NGP_START)
	$(CONFIGURE_NGP_LIBRETRO_START)
	$(CONFIGURE_NGP_LIBRETRO_MEDNAFEN_NGP_DEF)
	$(CONFIGURE_NGP_LIBRETRO_END)
	$(CONFIGURE_MAIN_NGP_END)
endef

$(eval $(generic-package))
