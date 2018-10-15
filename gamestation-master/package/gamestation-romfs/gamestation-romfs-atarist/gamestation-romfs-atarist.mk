################################################################################
#
# gamestation-romfs-atarist
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system atarist --extension '.st .ST .stx .STX .ipf .IPF .zip .ZIP' --fullname 'Atari ST' --platform atarist --theme atarist libretro:hatari:BR2_PACKAGE_LIBRETRO_HATARI

# Name the 3 vars as the package requires
GAMESTATION_ROMFS_ATARIST_SOURCE = 
GAMESTATION_ROMFS_ATARIST_SITE = 
GAMESTATION_ROMFS_ATARIST_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_ATARIST = atarist
SYSTEM_XML_ATARIST = $(@D)/$(SYSTEM_NAME_ATARIST).xml
# System rom path
SOURCE_ROMDIR_ATARIST = $(GAMESTATION_ROMFS_ATARIST_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in gamestation-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_HATARI),)
define CONFIGURE_MAIN_ATARIST_START
	$(call GAMESTATION_ROMFS_CALL_ADD_SYSTEM,$(SYSTEM_XML_ATARIST),Atari ST,$(SYSTEM_NAME_ATARIST),.st .ST .stx .STX .ipf .IPF .zip .ZIP,atarist,atarist)
endef

ifneq ($(BR2_PACKAGE_LIBRETRO_HATARI),)
define CONFIGURE_ATARIST_LIBRETRO_START
	$(call GAMESTATION_ROMFS_CALL_START_EMULATOR,$(SYSTEM_XML_ATARIST),libretro)
endef
ifeq ($(BR2_PACKAGE_LIBRETRO_HATARI),y)
define CONFIGURE_ATARIST_LIBRETRO_HATARI_DEF
	$(call GAMESTATION_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_ATARIST),hatari)
endef
endif

define CONFIGURE_ATARIST_LIBRETRO_END
	$(call GAMESTATION_ROMFS_CALL_END_EMULATOR,$(SYSTEM_XML_ATARIST))
endef
endif



define CONFIGURE_MAIN_ATARIST_END
	$(call GAMESTATION_ROMFS_CALL_END_SYSTEM,$(SYSTEM_XML_ATARIST),$(SOURCE_ROMDIR_ATARIST),$(@D))
endef
endif

define GAMESTATION_ROMFS_ATARIST_CONFIGURE_CMDS
	$(CONFIGURE_MAIN_ATARIST_START)
	$(CONFIGURE_ATARIST_LIBRETRO_START)
	$(CONFIGURE_ATARIST_LIBRETRO_HATARI_DEF)
	$(CONFIGURE_ATARIST_LIBRETRO_END)
	$(CONFIGURE_MAIN_ATARIST_END)
endef

$(eval $(generic-package))
