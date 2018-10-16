################################################################################
#
# gamestation-romfs-msx
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system msx --extension '.mx1 .MX1 .mx2 .MX2 .rom .ROM .dsk .DSK .cas .CAS .m3u .M3U .zip .ZIP' --fullname 'MSX' --platform msx --theme msx libretro:bluemsx:BR2_PACKAGE_LIBRETRO_BLUEMSX libretro:bluemsx:BR2_PACKAGE_LIBRETRO_BLUEMSX libretro:fmsx:BR2_PACKAGE_LIBRETRO_FMSX

# Name the 3 vars as the package requires
GAMESTATION_ROMFS_MSX_SOURCE = 
GAMESTATION_ROMFS_MSX_SITE = 
GAMESTATION_ROMFS_MSX_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_MSX = msx
SYSTEM_XML_MSX = $(@D)/$(SYSTEM_NAME_MSX).xml
# System rom path
SOURCE_ROMDIR_MSX = $(GAMESTATION_ROMFS_MSX_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in gamestation-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_BLUEMSX)$(BR2_PACKAGE_LIBRETRO_FMSX),)
define CONFIGURE_MAIN_MSX_START
	$(call GAMESTATION_ROMFS_CALL_ADD_SYSTEM,$(SYSTEM_XML_MSX),MSX,$(SYSTEM_NAME_MSX),.mx1 .MX1 .mx2 .MX2 .rom .ROM .dsk .DSK .cas .CAS .m3u .M3U .zip .ZIP,msx,msx)
endef

ifneq ($(BR2_PACKAGE_LIBRETRO_BLUEMSX)$(BR2_PACKAGE_LIBRETRO_FMSX),)
define CONFIGURE_MSX_LIBRETRO_START
	$(call GAMESTATION_ROMFS_CALL_START_EMULATOR,$(SYSTEM_XML_MSX),libretro)
endef
ifeq ($(BR2_PACKAGE_LIBRETRO_FMSX),y)
define CONFIGURE_MSX_LIBRETRO_FMSX_DEF
	$(call GAMESTATION_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_MSX),fmsx)
endef
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_BLUEMSX),y)
define CONFIGURE_MSX_LIBRETRO_BLUEMSX_DEF
	$(call GAMESTATION_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_MSX),bluemsx)
endef
endif

define CONFIGURE_MSX_LIBRETRO_END
	$(call GAMESTATION_ROMFS_CALL_END_EMULATOR,$(SYSTEM_XML_MSX))
endef
endif



define CONFIGURE_MAIN_MSX_END
	$(call GAMESTATION_ROMFS_CALL_END_SYSTEM,$(SYSTEM_XML_MSX),$(SOURCE_ROMDIR_MSX),$(@D))
endef
endif

define GAMESTATION_ROMFS_MSX_CONFIGURE_CMDS
	$(CONFIGURE_MAIN_MSX_START)
	$(CONFIGURE_MSX_LIBRETRO_START)
	$(CONFIGURE_MSX_LIBRETRO_FMSX_DEF)
	$(CONFIGURE_MSX_LIBRETRO_BLUEMSX_DEF)
	$(CONFIGURE_MSX_LIBRETRO_END)
	$(CONFIGURE_MAIN_MSX_END)
endef

$(eval $(generic-package))
