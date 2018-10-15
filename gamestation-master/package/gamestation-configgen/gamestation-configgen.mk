################################################################################
#
# gamestation configgen version https://gitlab.com/gamestation/gamestation-configgen
#
################################################################################

GAMESTATION_CONFIGGEN_VERSION = ac0c430a1652c0cc6d315b9cd95579c707c31f81

GAMESTATION_CONFIGGEN_SITE = https://gitlab.com/gamestation/gamestation-configgen.git
GAMESTATION_CONFIGGEN_SITE_METHOD = git

GAMESTATION_CONFIGGEN_LICENSE = GPL2
GAMESTATION_CONFIGGEN_DEPENDENCIES = python

GAMESTATION_CONFIGGEN_SETUP_TYPE = distutils

$(eval $(python-package))
