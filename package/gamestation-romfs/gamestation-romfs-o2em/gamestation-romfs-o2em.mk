################################################################################
#
# gamestation-romfs-o2em
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system o2em --extension '.bin .BIN .zip .ZIP' --fullname 'Odyssey2' --platform odyssey2 --theme odyssey2 libretro:o2em:BR2_PACKAGE_LIBRETRO_O2EM

# Name the 3 vars as the package requires
GAMESTATION_ROMFS_O2EM_SOURCE = 
GAMESTATION_ROMFS_O2EM_SITE = 
GAMESTATION_ROMFS_O2EM_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_O2EM = o2em
SYSTEM_XML_O2EM = $(@D)/$(SYSTEM_NAME_O2EM).xml
# System rom path
SOURCE_ROMDIR_O2EM = $(GAMESTATION_ROMFS_O2EM_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in gamestation-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_O2EM),)
define CONFIGURE_MAIN_O2EM_START
	$(call GAMESTATION_ROMFS_CALL_ADD_SYSTEM,$(SYSTEM_XML_O2EM),Odyssey2,$(SYSTEM_NAME_O2EM),.bin .BIN .zip .ZIP,odyssey2,odyssey2)
endef

ifneq ($(BR2_PACKAGE_LIBRETRO_O2EM),)
define CONFIGURE_O2EM_LIBRETRO_START
	$(call GAMESTATION_ROMFS_CALL_START_EMULATOR,$(SYSTEM_XML_O2EM),libretro)
endef
ifeq ($(BR2_PACKAGE_LIBRETRO_O2EM),y)
define CONFIGURE_O2EM_LIBRETRO_O2EM_DEF
	$(call GAMESTATION_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_O2EM),o2em)
endef
endif

define CONFIGURE_O2EM_LIBRETRO_END
	$(call GAMESTATION_ROMFS_CALL_END_EMULATOR,$(SYSTEM_XML_O2EM))
endef
endif



define CONFIGURE_MAIN_O2EM_END
	$(call GAMESTATION_ROMFS_CALL_END_SYSTEM,$(SYSTEM_XML_O2EM),$(SOURCE_ROMDIR_O2EM),$(@D))
endef
endif

define GAMESTATION_ROMFS_O2EM_CONFIGURE_CMDS
	$(CONFIGURE_MAIN_O2EM_START)
	$(CONFIGURE_O2EM_LIBRETRO_START)
	$(CONFIGURE_O2EM_LIBRETRO_O2EM_DEF)
	$(CONFIGURE_O2EM_LIBRETRO_END)
	$(CONFIGURE_MAIN_O2EM_END)
endef

$(eval $(generic-package))
