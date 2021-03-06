################################################################################
#
# gamestation-romfs
#
################################################################################

GAMESTATION_ROMFS_SOURCE =
GAMESTATION_ROMFS_SITE =
GAMESTATION_ROMFS_INSTALL_STAGING = NO

ES_SYSTEMS = $(@D)/es_systems.cfg
ES_SYSTEMS_TMP = $(ES_SYSTEMS).tmp
TARGET_ES_SYSTEMS_DIR = $(TARGET_DIR)/gamestation/share_init/system/.emulationstation
TARGET_ROMDIR = $(TARGET_DIR)/gamestation/share_init/

CONFIGGEN_STD_CMD = python /usr/lib/python2.7/site-packages/configgen/emulatorlauncher.pyc %CONTROLLERSCONFIG% -system %SYSTEM% -rom %ROM% -emulator %EMULATOR% -core %CORE% -ratio %RATIO% %NETPLAY%

# Each emulator must define :
#  - its es_systems.cfg entry
#  - its source roms folder
# You MUST add an empty line at the end of the define otherwise some commands
# will overlap and fail

# function to add the new system
# $1 = XML file
# $2 = full system name
# $3 = short system name
# $4 = e=list of extensions ex : .zip .ZIP
# $5 = platform
# $6 = theme
define GAMESTATION_ROMFS_CALL_ADD_SYSTEM
    echo -e '<system>\n' \
    '<fullname>$(2)</fullname>\n' \
    "<name>$(3)</name>\n" \
    '<path>/gamestation/share/roms/$(3)</path>\n' \
    '<extension>$(4)</extension>\n' \
    "<command>$(CONFIGGEN_STD_CMD)</command>\n" \
    '<platform>$(5)</platform>\n' \
    '<theme>$(6)</theme>\n' \
    '<emulators>' > $(1)
endef

# function to add the emulator part of a XML
# $1 = XML file
# $2 = emulator name name
GAMESTATION_ROMFS_CALL_START_EMULATOR = echo -e '<emulator name="$(2)">\n<cores>' >> $(1)

# function to add the core part of a XML
# $1 = XML file
# $2 = core name
GAMESTATION_ROMFS_CALL_ADD_CORE = echo -e '<core>$(2)</core>' >> $(1)

# function to close the emulator part of a XML
# $1 = XML file
GAMESTATION_ROMFS_CALL_END_EMULATOR = echo -e '</cores>\n</emulator>' >> $(1)

# function to add a standlone emulator part of a XML
# $1 = XML file
# $2 = emulator name name
GAMESTATION_ROMFS_CALL_STANDALONE_EMULATOR = echo -e '<emulator name="$(2)"/>' >> $(1)

# function to add the new system
# $1 = XML file
# $2 = system rom source dir
# $3 = system rom destination dir
define GAMESTATION_ROMFS_CALL_END_SYSTEM
    echo -e '</emulators>\n</system>' >> $(1)
    cp -R $(2) $(3)
endef

# function to add a new system that only has a standalone emulator
# $1 = XML file
# $2 = full system name
# $3 = short system name
# $4 = e=list of extensions ex : .zip .ZIP
# $5 = platform
# $6 = theme
# $7 = system rom source dir
# $8 = system rom destination dir
GAMESTATION_ROMFS_CALL_ADD_STANDALONE_SYSTEM = $(call GAMESTATION_ROMFS_CALL_ADD_STANDALONE_SYSTEM_FULLPATH,$(1),$(2),$(3),$(4),$(5),$(6),$(7),$(8),/gamestation/share/roms/$(3))

# function to add a new system that only has a standalone emulator specifying
# its ull path to the roms folder
# $1 = XML file
# $2 = full system name
# $3 = short system name
# $4 = e=list of extensions ex : .zip .ZIP
# $5 = platform
# $6 = theme
# $7 = system rom source dir
# $8 = system rom destination dir
# $9 = full path to roms
define GAMESTATION_ROMFS_CALL_ADD_STANDALONE_SYSTEM_FULLPATH
    echo -e '<system>\n' \
    '<fullname>$(2)</fullname>\n' \
    "<name>$(3)</name>\n" \
    '<path>$(9)</path>\n' \
    '<extension>$(4)</extension>\n' \
    "<command>$(CONFIGGEN_STD_CMD)</command>\n" \
    '<platform>$(5)</platform>\n' \
    '<theme>$(6)</theme>\n' \
    '<emulators />\n' \
    '</system>' >> $(1)
    cp -R $(7) $(8)
endef

# Init the es_systems.cfg
# Keep the empty line as there are several commands to chain at configure
define GAMESTATION_ROMFS_ES_SYSTEMS
	echo '<?xml version="1.0"?>' > $(ES_SYSTEMS_TMP)
	echo '<systemList>' >>  $(ES_SYSTEMS_TMP)
	cat $(@D)/../gamestation-romfs-*/*.xml >> $(ES_SYSTEMS_TMP)
	echo -e '<system>\n' \
		"\t<fullname>Favorites</fullname>\n" \
		'\t<name>favorites</name>\n' \
		"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
		"\t<theme>favorites</theme>\n" \
	"</system>\n" \
	'</systemList>' >>  $(ES_SYSTEMS_TMP)
	xmllint --format $(ES_SYSTEMS_TMP) > $(ES_SYSTEMS)

endef
GAMESTATION_ROMFS_CONFIGURE_CMDS += $(GAMESTATION_ROMFS_ES_SYSTEMS)

# Copy rom dirs
define GAMESTATION_ROMFS_ROM_DIRS
	cp -R $(@D)/../gamestation-romfs-*/roms $(@D)

endef
GAMESTATION_ROMFS_CONFIGURE_CMDS += $(GAMESTATION_ROMFS_ROM_DIRS)

# Copy from build to target
define GAMESTATION_ROMFS_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_ROMDIR)/roms
	mkdir -p $(TARGET_ES_SYSTEMS_DIR)
	$(INSTALL) -D -m 0644 $(ES_SYSTEMS) $(TARGET_ES_SYSTEMS_DIR)
	cp -r $(@D)/roms $(TARGET_ROMDIR)
endef

# Add necessary dependencies
# System: amiga600
 ifeq ($(BR2_PACKAGE_AMIBERRY),y)
 	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-amiga600
endif
 	
# System: amiga1200
 ifeq ($(BR2_PACKAGE_AMIBERRY),y)
 	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-amiga1200
endif
 	
# System: amstradcpc
ifneq ($(BR2_PACKAGE_LIBRETRO_CAP32)$(BR2_PACKAGE_LIBRETRO_CROCODS),)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-amstradcpc
endif

# System: apple2
ifeq ($(BR2_PACKAGE_LINAPPLE_PIE),y)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-apple2
endif

# System: atari2600
ifneq ($(BR2_PACKAGE_LIBRETRO_STELLA),)
    GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-atari2600
endif

# System: atari7800
ifneq ($(BR2_PACKAGE_LIBRETRO_PROSYSTEM),)
    GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-atari7800
endif

# System: atarist
ifneq ($(BR2_PACKAGE_LIBRETRO_HATARI),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-atarist
endif

# System: c64
ifneq ($(BR2_PACKAGE_LIBRETRO_VICE),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-c64
endif

# System: cavestory
ifneq ($(BR2_PACKAGE_LIBRETRO_NXENGINE),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-cavestory
endif

# System: colecovision
ifneq ($(BR2_PACKAGE_LIBRETRO_BLUEMSX),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-colecovision
endif

# System: daphne
ifeq ($(BR2_PACKAGE_HYPSEUS),y)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-daphne
endif

# System: dos
ifeq ($(BR2_PACKAGE_DOSBOX),y)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-dos
endif

# Sytem: dreamcast
ifeq ($(BR2_PACKAGE_REICAST),y)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-dreamcast
endif

# System: fba
ifneq ($(BR2_PACKAGE_PIFBA),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-fba
endif

# System: fba_libretro
ifneq ($(BR2_PACKAGE_LIBRETRO_FBA),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-fba_libretro
endif

# System: fds
ifneq ($(BR2_PACKAGE_LIBRETRO_FCEUMM)$(BR2_PACKAGE_LIBRETRO_NESTOPIA),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-fds
endif

# System: gamecube
ifeq ($(BR2_PACKAGE_DOLPHIN_EMU),y)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-gamecube
endif

# System: gamegear
ifneq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX),)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-gamegear
endif

# System: gb
ifneq ($(BR2_PACKAGE_LIBRETRO_GAMBATTE)$(BR2_PACKAGE_LIBRETRO_TGBDUAL),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-gb
endif

# System: gba
ifneq ($(BR2_PACKAGE_LIBRETRO_GPSP)$(BR2_PACKAGE_LIBRETRO_MGBA)$(BR2_PACKAGE_LIBRETRO_METEOR),)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-gba
endif

# System: gbc
ifneq ($(BR2_PACKAGE_LIBRETRO_GAMBATTE)$(BR2_PACKAGE_LIBRETRO_TGBDUAL),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-gbc
endif

# System: gw
ifneq ($(BR2_PACKAGE_LIBRETRO_GW),)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-gw
endif

# System: lutro
ifneq ($(BR2_PACKAGE_LIBRETRO_LUTRO),)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-lutro
endif

# System: lynx
ifneq ($(BR2_PACKAGE_LIBRETRO_HANDY)$(BR2_PACKAGE_LIBRETRO_BEETLE_LYNX),)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-lynx
endif

# System: mame
ifneq ($(BR2_PACKAGE_LIBRETRO_MAME2003)$(BR2_PACKAGE_LIBRETRO_IMAME)$(BR2_PACKAGE_ADVANCEMAME)$(BR2_PACKAGE_LIBRETRO_MAME2010),)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-mame
endif

# System: mastersystem
ifneq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX)$(BR2_PACKAGE_LIBRETRO_PICODRIVE),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-mastersystem
endif

# System: megadrive
ifneq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX)$(BR2_PACKAGE_LIBRETRO_PICODRIVE),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-megadrive
endif

# System: moonlight
ifeq ($(BR2_PACKAGE_MOONLIGHT_EMBEDDED),y)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-moonlight
endif

# System: msx
ifneq ($(BR2_PACKAGE_LIBRETRO_FMSX)$(BR2_PACKAGE_LIBRETRO_BLUEMSX),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-msx
endif

# System: msx1
ifneq ($(BR2_PACKAGE_LIBRETRO_FMSX)$(BR2_PACKAGE_LIBRETRO_BLUEMSX),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-msx1
endif

# System: msx2
ifneq ($(BR2_PACKAGE_LIBRETRO_FMSX)$(BR2_PACKAGE_LIBRETRO_BLUEMSX),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-msx2
endif

# System: n64
ifneq ($(BR2_PACKAGE_MUPEN64PLUS_GLIDEN64)$(BR2_PACKAGE_MUPEN64PLUS_GLES2)$(BR2_PACKAGE_MUPEN64PLUS_GLES2RICE)$(BR2_PACKAGE_MUPEN64PLUS_VIDEO_GLIDE64MK2)$(BR2_PACKAGE_LIBRETRO_GLUPEN64),)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-n64
endif

# System: nds
ifneq ($(BR2_PACKAGE_LIBRETRO_DESMUME)$(BR2_PACKAGE_LIBRETRO_MELONDS),)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-nds
endif

# System: neogeo
ifneq ($(BR2_PACKAGE_LIBRETRO_MAME2003)$(BR2_PACKAGE_LIBRETRO_IMAME)$(BR2_PACKAGE_LIBRETRO_FBA)$(BR2_PACKAGE_PIFBA)$(BR2_PACKAGE_LIBRETRO_MAME2010),)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-neogeo
endif

# System: nes
ifneq ($(BR2_PACKAGE_LIBRETRO_FCEUMM)$(BR2_PACKAGE_LIBRETRO_FCEUNEXT)$(BR2_PACKAGE_LIBRETRO_NESTOPIA)$(BR2_PACKAGE_LIBRETRO_QUICKNES),)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-nes
endif

# System: ngp
ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_NGP),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-ngp
endif

# System: ngpc
ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_NGP),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-ngpc
endif

# System: o2em
ifneq ($(BR2_PACKAGE_LIBRETRO_O2EM),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-o2em
endif

# System: pcengine
ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX)$(BR2_PACKAGE_LIBRETRO_BEETLE_PCE),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-pcengine
endif

# System: pcenginecd
ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX)$(BR2_PACKAGE_LIBRETRO_BEETLE_PCE),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-pcenginecd
endif

# System: supergrafx
ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX)$(BR2_PACKAGE_LIBRETRO_BEETLE_PCE),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-supergrafx
endif

# System: psp
ifeq ($(BR2_PACKAGE_PPSSPP),y)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-psp
endif

# System: psx
ifneq ($(BR2_PACKAGE_LIBRETRO_PCSX)$(BR2_PACKAGE_LIBRETRO_BEETLE_PSX)$(BR2_PACKAGE_LIBRETRO_BEETLE_PSX_HW),)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-psx
endif

# System: prboom
ifneq ($(BR2_PACKAGE_LIBRETRO_PRBOOM),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-prboom
endif

# System: scummvm
ifeq ($(BR2_PACKAGE_SCUMMVM),y)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-scummvm
endif

# System: sega32x
ifneq ($(BR2_PACKAGE_LIBRETRO_PICODRIVE),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-sega32x
endif

# System: segacd
ifneq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX)$(BR2_PACKAGE_LIBRETRO_PICODRIVE),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-segacd
endif

# System: sg1000
ifneq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX),)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-sg1000
endif

# System: snes
ifneq ($(BR2_PACKAGE_LIBRETRO_CATSFC)$(BR2_PACKAGE_LIBRETRO_POCKETSNES)$(BR2_PACKAGE_LIBRETRO_SNES9X_NEXT)$(BR2_PACKAGE_LIBRETRO_SNES9X),)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-snes
endif

# System: thomson
ifneq ($(BR2_PACKAGE_LIBRETRO_THEODORE),)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-thomson
endif

# System: vectrex
ifneq ($(BR2_PACKAGE_LIBRETRO_VECX),)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-vectrex
endif

# System: virtualboy
ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_VB),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-virtualboy
endif

# System: wii
ifeq ($(BR2_PACKAGE_DOLPHIN_EMU),y)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-wii
endif

# System: wswan
ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_WSWAN),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-wswan
endif

# System: wswanc
ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_WSWAN),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-wswanc
endif

# System: x68000
ifneq ($(BR2_PACKAGE_LIBRETRO_PX68K),)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-x68000
endif

# System: zx81
ifneq ($(BR2_PACKAGE_LIBRETRO_81),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-zx81
endif

# System: zxspectrum
ifneq ($(BR2_PACKAGE_LIBRETRO_FUSE),)
        GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-zxspectrum
endif

# System: 3do
ifneq ($(BR2_PACKAGE_LIBRETRO_4DO),)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-3do
endif

# System: atari800
ifneq ($(BR2_PACKAGE_LIBRETRO_ATARI800),)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-atari800
endif

# System: atari5200
ifneq ($(BR2_PACKAGE_LIBRETRO_ATARI800),)
	GAMESTATION_ROMFS_DEPENDENCIES += gamestation-romfs-atari5200
endif

$(eval $(generic-package))
