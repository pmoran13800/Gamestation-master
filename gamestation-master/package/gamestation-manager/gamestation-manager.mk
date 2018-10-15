################################################################################
#
# gamestation-manager
#
################################################################################
GAMESTATION_MANAGER_VERSION = gamestation-4.1.x
GAMESTATION_MANAGER_SITE = $(call github,sveetch,gamestation-manager,$(GAMESTATION_MANAGER_VERSION))
GAMESTATION_MANAGER_DEPENDENCIES = python python-psutil python-django python-autobreadcrumbs

define GAMESTATION_MANAGER_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/gamestation-manager
	cp -r $(@D)/* $(TARGET_DIR)/usr/gamestation-manager
	cp $(GAMESTATION_MANAGER_PKGDIR)/bd/db.sqlite3 $(TARGET_DIR)/usr/gamestation-manager
endef

$(eval $(generic-package))
