################################################################################
#
# gamestation-romfs-pcenginecd
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system pcenginecd --extension '.cue .CUE .ccd .CCD .chd .CHD' --fullname 'PC Engine CD' --platform pcenginecd --theme pcenginecd libretro:mednafen_supergrafx:BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX libretro:pce:BR2_PACKAGE_LIBRETRO_BEETLE_PCE

# Name the 3 vars as the package requires
GAMESTATION_ROMFS_PCENGINECD_SOURCE = 
GAMESTATION_ROMFS_PCENGINECD_SITE = 
GAMESTATION_ROMFS_PCENGINECD_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_PCENGINECD = pcenginecd
SYSTEM_XML_PCENGINECD = $(@D)/$(SYSTEM_NAME_PCENGINECD).xml
# System rom path
SOURCE_ROMDIR_PCENGINECD = $(GAMESTATION_ROMFS_PCENGINECD_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in gamestation-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX)$(BR2_PACKAGE_LIBRETRO_BEETLE_PCE),)
define CONFIGURE_MAIN_PCENGINECD_START
	$(call GAMESTATION_ROMFS_CALL_ADD_SYSTEM,$(SYSTEM_XML_PCENGINECD),PC Engine CD,$(SYSTEM_NAME_PCENGINECD),.cue .CUE .ccd .CCD .chd .CHD,pcenginecd,pcenginecd)
endef

ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX)$(BR2_PACKAGE_LIBRETRO_BEETLE_PCE),)
define CONFIGURE_PCENGINECD_LIBRETRO_START
	$(call GAMESTATION_ROMFS_CALL_START_EMULATOR,$(SYSTEM_XML_PCENGINECD),libretro)
endef
ifeq ($(BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX),y)
define CONFIGURE_PCENGINECD_LIBRETRO_MEDNAFEN_SUPERGRAFX_DEF
	$(call GAMESTATION_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_PCENGINECD),mednafen_supergrafx)
endef
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_BEETLE_PCE),y)
define CONFIGURE_PCENGINECD_LIBRETRO_PCE_DEF
	$(call GAMESTATION_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_PCENGINECD),pce)
endef
endif

define CONFIGURE_PCENGINECD_LIBRETRO_END
	$(call GAMESTATION_ROMFS_CALL_END_EMULATOR,$(SYSTEM_XML_PCENGINECD))
endef
endif



define CONFIGURE_MAIN_PCENGINECD_END
	$(call GAMESTATION_ROMFS_CALL_END_SYSTEM,$(SYSTEM_XML_PCENGINECD),$(SOURCE_ROMDIR_PCENGINECD),$(@D))
endef
endif

define GAMESTATION_ROMFS_PCENGINECD_CONFIGURE_CMDS
	$(CONFIGURE_MAIN_PCENGINECD_START)
	$(CONFIGURE_PCENGINECD_LIBRETRO_START)
	$(CONFIGURE_PCENGINECD_LIBRETRO_MEDNAFEN_SUPERGRAFX_DEF)
	$(CONFIGURE_PCENGINECD_LIBRETRO_PCE_DEF)
	$(CONFIGURE_PCENGINECD_LIBRETRO_END)
	$(CONFIGURE_MAIN_PCENGINECD_END)
endef

$(eval $(generic-package))
