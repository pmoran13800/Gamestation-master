################################################################################
#
# gamestation-romfs-msx2
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system msx2 --extension '.mx1 .MX1 .mx2 .MX2 .rom .ROM .dsk .DSK .cas .CAS .m3u .M3U .zip .ZIP' --fullname 'MSX2' --platform msx --theme msx2 libretro:bluemsx:BR2_PACKAGE_LIBRETRO_BLUEMSX libretro:fmsx:BR2_PACKAGE_LIBRETRO_FMSX

# Name the 3 vars as the package requires
GAMESTATION_ROMFS_MSX2_SOURCE = 
GAMESTATION_ROMFS_MSX2_SITE = 
GAMESTATION_ROMFS_MSX2_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_MSX2 = msx2
SYSTEM_XML_MSX2 = $(@D)/$(SYSTEM_NAME_MSX2).xml
# System rom path
SOURCE_ROMDIR_MSX2 = $(GAMESTATION_ROMFS_MSX2_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in gamestation-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_BLUEMSX)$(BR2_PACKAGE_LIBRETRO_FMSX),)
define CONFIGURE_MAIN_MSX2_START
	$(call GAMESTATION_ROMFS_CALL_ADD_SYSTEM,$(SYSTEM_XML_MSX2),MSX2,$(SYSTEM_NAME_MSX2),.mx1 .MX1 .mx2 .MX2 .rom .ROM .dsk .DSK .cas .CAS .m3u .M3U .zip .ZIP,msx,msx2)
endef

ifneq ($(BR2_PACKAGE_LIBRETRO_BLUEMSX)$(BR2_PACKAGE_LIBRETRO_FMSX),)
define CONFIGURE_MSX2_LIBRETRO_START
	$(call GAMESTATION_ROMFS_CALL_START_EMULATOR,$(SYSTEM_XML_MSX2),libretro)
endef
ifeq ($(BR2_PACKAGE_LIBRETRO_FMSX),y)
define CONFIGURE_MSX2_LIBRETRO_FMSX_DEF
	$(call GAMESTATION_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_MSX2),fmsx)
endef
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_BLUEMSX),y)
define CONFIGURE_MSX2_LIBRETRO_BLUEMSX_DEF
	$(call GAMESTATION_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_MSX2),bluemsx)
endef
endif

define CONFIGURE_MSX2_LIBRETRO_END
	$(call GAMESTATION_ROMFS_CALL_END_EMULATOR,$(SYSTEM_XML_MSX2))
endef
endif



define CONFIGURE_MAIN_MSX2_END
	$(call GAMESTATION_ROMFS_CALL_END_SYSTEM,$(SYSTEM_XML_MSX2),$(SOURCE_ROMDIR_MSX2),$(@D))
endef
endif

define GAMESTATION_ROMFS_MSX2_CONFIGURE_CMDS
	$(CONFIGURE_MAIN_MSX2_START)
	$(CONFIGURE_MSX2_LIBRETRO_START)
	$(CONFIGURE_MSX2_LIBRETRO_FMSX_DEF)
	$(CONFIGURE_MSX2_LIBRETRO_BLUEMSX_DEF)
	$(CONFIGURE_MSX2_LIBRETRO_END)
	$(CONFIGURE_MAIN_MSX2_END)
endef

$(eval $(generic-package))
