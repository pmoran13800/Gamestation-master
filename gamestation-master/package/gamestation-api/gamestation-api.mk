################################################################################
#
# GAMESTATION_API
#
################################################################################
GAMESTATION_API_VERSION = 1.1.x
GAMESTATION_API_SITE = $(call github,gamestation,gamestation-api,$(GAMESTATION_API_VERSION))
GAMESTATION_API_DEPENDENCIES = nodejs

NPM = $(TARGET_CONFIGURE_OPTS) \
	LD="$(TARGET_CXX)" \
	npm_config_arch=arm \
	npm_config_target_arch=arm \
	npm_config_build_from_source=true \
	npm_config_nodedir=$(BUILD_DIR)/nodejs-$(NODEJS_VERSION) \
	$(HOST_DIR)/usr/bin/npm


define GAMESTATION_API_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/gamestation-api
	cp -r $(@D)/* \
		$(TARGET_DIR)/usr/gamestation-api

	cd $(TARGET_DIR)/usr/gamestation-api && mkdir -p node_modules && \
		$(NPM) install --production \

endef

# Must be on fsoverlay and is already here :)
#define GAMESTATION_API_INSTALL_INIT_SYSV
	#TODO The init script shouldn't start by default
	#$(INSTALL) -m 0755 -D package/GAMESTATION_API/S92GAMESTATION_API $(TARGET_DIR)/etc/init.d/S92GAMESTATION_API
#endef
$(eval $(generic-package))
