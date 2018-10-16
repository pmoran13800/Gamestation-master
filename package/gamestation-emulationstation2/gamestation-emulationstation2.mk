################################################################################
#
# EmulationStation 2 - gamestation version https://gitlab.com/gamestation/gamestation-emulationstation
#
################################################################################

ifeq ($(BR2_PACKAGE_GAMESTATION_TARGET_RPI3),y)
        GAMESTATION_EMULATIONSTATION2_CONF_OPTS = -DRPI_VERSION=3
else ifeq ($(BR2_PACKAGE_GAMESTATION_TARGET_RPI2),y)
        GAMESTATION_EMULATIONSTATION2_CONF_OPTS = -DRPI_VERSION=2
else ifeq ($(BR2_PACKAGE_GAMESTATION_TARGET_RPI1),y)
        GAMESTATION_EMULATIONSTATION2_CONF_OPTS = -DRPI_VERSION=1
else ifeq ($(BR2_PACKAGE_GAMESTATION_TARGET_RPI0),y)
        GAMESTATION_EMULATIONSTATION2_CONF_OPTS = -DRPI_VERSION=1
endif

GAMESTATION_EMULATIONSTATION2_SITE = https://gitlab.com/gamestation/gamestation-emulationstation.git
GAMESTATION_EMULATIONSTATION2_VERSION = e0dbbd9f32fee4ec16cccd30db7be496d5bf214a
GAMESTATION_EMULATIONSTATION2_SITE_METHOD = git
GAMESTATION_EMULATIONSTATION2_LICENSE = MIT
GAMESTATION_EMULATIONSTATION2_DEPENDENCIES = sdl2 sdl2_mixer boost freeimage freetype eigen alsa-lib \
	libcurl openssl

ifeq ($(BR2_PACKAGE_HAS_LIBGL),y)
GAMESTATION_EMULATIONSTATION2_DEPENDENCIES += libgl
endif

ifeq ($(BR2_PACKAGE_HAS_LIBGLES),y)
GAMESTATION_EMULATIONSTATION2_DEPENDENCIES += libgles
endif


define GAMESTATION_EMULATIONSTATION2_RPI_FIXUP
	$(SED) 's|/opt/vc/include|$(STAGING_DIR)/usr/include|g' $(@D)/CMakeLists.txt
	$(SED) 's|/opt/vc/lib|$(STAGING_DIR)/usr/lib|g' $(@D)/CMakeLists.txt
	$(SED) 's|/usr/lib|$(STAGING_DIR)/usr/lib|g' $(@D)/CMakeLists.txt
endef

GAMESTATION_EMULATIONSTATION2_PRE_CONFIGURE_HOOKS += GAMESTATION_EMULATIONSTATION2_RPI_FIXUP

$(eval $(cmake-package))
