################################################################################
#
# gamestation-romfs-gbc
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system gbc --extension '.gb .GB .gbc .GBC .zip .ZIP' --fullname 'Game Boy Color' --platform gbc --theme gbc libretro:gambatte:BR2_PACKAGE_LIBRETRO_GAMBATTE libretro:tgbdual:BR2_PACKAGE_LIBRETRO_TGBDUAL libretro:mgba:BR2_PACKAGE_LIBRETRO_MGBA

# Name the 3 vars as the package requires
GAMESTATION_ROMFS_GBC_SOURCE = 
GAMESTATION_ROMFS_GBC_SITE = 
GAMESTATION_ROMFS_GBC_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_GBC = gbc
SYSTEM_XML_GBC = $(@D)/$(SYSTEM_NAME_GBC).xml
# System rom path
SOURCE_ROMDIR_GBC = $(GAMESTATION_ROMFS_GBC_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in gamestation-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_GAMBATTE)$(BR2_PACKAGE_LIBRETRO_TGBDUAL)$(BR2_PACKAGE_LIBRETRO_MGBA),)
define CONFIGURE_MAIN_GBC_START
	$(call GAMESTATION_ROMFS_CALL_ADD_SYSTEM,$(SYSTEM_XML_GBC),Game Boy Color,$(SYSTEM_NAME_GBC),.gb .GB .gbc .GBC .zip .ZIP,gbc,gbc)
endef

ifneq ($(BR2_PACKAGE_LIBRETRO_GAMBATTE)$(BR2_PACKAGE_LIBRETRO_TGBDUAL)$(BR2_PACKAGE_LIBRETRO_MGBA),)
define CONFIGURE_GBC_LIBRETRO_START
	$(call GAMESTATION_ROMFS_CALL_START_EMULATOR,$(SYSTEM_XML_GBC),libretro)
endef
ifeq ($(BR2_PACKAGE_LIBRETRO_MGBA),y)
define CONFIGURE_GBC_LIBRETRO_MGBA_DEF
	$(call GAMESTATION_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_GBC),mgba)
endef
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_GAMBATTE),y)
define CONFIGURE_GBC_LIBRETRO_GAMBATTE_DEF
	$(call GAMESTATION_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_GBC),gambatte)
endef
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_TGBDUAL),y)
define CONFIGURE_GBC_LIBRETRO_TGBDUAL_DEF
	$(call GAMESTATION_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_GBC),tgbdual)
endef
endif

define CONFIGURE_GBC_LIBRETRO_END
	$(call GAMESTATION_ROMFS_CALL_END_EMULATOR,$(SYSTEM_XML_GBC))
endef
endif



define CONFIGURE_MAIN_GBC_END
	$(call GAMESTATION_ROMFS_CALL_END_SYSTEM,$(SYSTEM_XML_GBC),$(SOURCE_ROMDIR_GBC),$(@D))
endef
endif

define GAMESTATION_ROMFS_GBC_CONFIGURE_CMDS
	$(CONFIGURE_MAIN_GBC_START)
	$(CONFIGURE_GBC_LIBRETRO_START)
	$(CONFIGURE_GBC_LIBRETRO_MGBA_DEF)
	$(CONFIGURE_GBC_LIBRETRO_GAMBATTE_DEF)
	$(CONFIGURE_GBC_LIBRETRO_TGBDUAL_DEF)
	$(CONFIGURE_GBC_LIBRETRO_END)
	$(CONFIGURE_MAIN_GBC_END)
endef

$(eval $(generic-package))
