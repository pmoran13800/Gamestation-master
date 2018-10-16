################################################################################
#
# GAMESTATION_MANAGER2
#
################################################################################
GAMESTATION_MANAGER2_VERSION = v2.2.2
GAMESTATION_MANAGER2_SITE = git://github.com/DjLeChuck/gamestation-manager

GAMESTATION_MANAGER2_DEPENDENCIES = nodejs


define GAMESTATION_MANAGER2_BUILD_CMDS		
	$(NPM) --prefix $(@D) run installboth
	$(NPM) --prefix $(@D) run buildboth
	rm -rf $(@D)/release
	mkdir -p $(@D)/release/config
	mkdir -p $(@D)/release/client
	mkdir -p $(@D)/release/locales
	cp -R $(@D)/client/build $(@D)/release/client
	find $(@D) -type f -name '*.map' -exec rm {} \;
	cp $(@D)/config/default.js $(@D)/release/config
	cp $(@D)/config/production.js $(@D)/release/config
	cp -R $(@D)/dist $(@D)/release
	cp $(@D)/locales/*.json $(@D)/release/locales
	cp $(@D)/package.json $(@D)/release
	$(NPM) install --production $(@D)/release/ --prefix $(@D)/release/
endef
    
define GAMESTATION_MANAGER2_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/gamestation-manager2
	cp -r $(@D)/release/* $(TARGET_DIR)/usr/gamestation-manager2
endef

$(eval $(generic-package))
