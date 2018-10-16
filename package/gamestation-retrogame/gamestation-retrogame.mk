################################################################################
#
# Retrogame Gamestation https://github.com/ian57/Gamestation-Retrogame-2Players-Pi2
#
################################################################################
GAMESTATION_RETROGAME_VERSION = 8d3e90ed179146d717201b6f4337290100f9ca26
GAMESTATION_RETROGAME_SITE = $(call github,gamestation,Gamestation-Retrogame-2Players-Pi2,$(GAMESTATION_RETROGAME_VERSION))

define GAMESTATION_RETROGAME_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) retrogame
endef

define GAMESTATION_RETROGAME_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/retrogame \
		$(TARGET_DIR)/usr/bin/gamestation-retrogame
endef

$(eval $(generic-package))
