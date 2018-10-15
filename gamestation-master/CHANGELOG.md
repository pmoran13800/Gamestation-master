# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [unreleased]
- Add support for Mayflash GameCube adapter
- ES: better cyrillic display
- Add ipega 9055 udev rule
- New upgrade procedure to prepare for the future
- ES: fix scraped folders display
- ES: improve image loading
- ES: now automatically reboots once the upgrade is ready
- Atari 8 Bits: Added Atari 800 and Atari 5200 support - Thanks to dubbows!
- MSX: Fixed Bluemsx core

## [18.07.13] - 2018-07-13
- Bump desmume to desmume2015
- fix: SELECT as hotkey sometimes messy with arcade
- ES: Arcade roms fullname in Netplay GUID
- ES: No game launch if core doesn't match
- ES: Game not listed in lobby if password protected
- ES: remove netplay popup to prevent some crash
- Wifi: options were not saved with nfs cifs or configurations - fixed
- Daphne: joystick improvements / bug corrections
- N64 rice: fix blank screen
- N64 GlideN64 and other plugins: also fix blank screen
- pifba: make sure it's only available for systems supporting it
- Set the gamestation tag for netplay elsewhere

## [18.06.27] - 2018-06-27
- Adding introGamestationEASports.mp4
- Theme: updated "controls" gamelistview + bugfixes and enhancements
- ES: updated translations
- ES: Added Netplay option in menus + menus to add roms hashs in gamelists
- ES: Added Netplay : GUI for client mode and button to launch as host
- ES: Fixed clock not in local time
- ES: Fixed old themes crash
- ES: Option for popup position
- ES: Help messages in popups
- ES: Slider for popup duration 
- ES: Languages names in their own language
- Bump kodi-plugin-video-youtube to 5.5.1
- ES: Refactored gamepad configuration panel
- ES: Update Emulator / Core selection process to avoid gui inception and to display default values
- ES: Update font size on game metadata gui
- ES: Remove dead code of RomsManager
- ES: Make gamelist sort persistent
- ES: Show folder content in detail panel
- ES: Show single folder game as game in parent list
- ES: Added an option to list folder content instead of folder name
- ES: Only display available letter in JumpToLetter + Append figures
- ES: Avoid reload of images if source doesn't changed
- ES: Update Games lists from GameList menu
- ES: Set Menu list in loop mode
- ES: Fixed back button in gamelist
- ES: Fixed back from game launch
- ES: Fixed detailed panel missing when jumping to letter A
- ES: Fixed set a game favorite for the first time (required two switches before)
- ES: Stay is selected sub-folder when changing sort type / order in gamelist
- gamestation-config.sh: added getEmulatorDefaults
- Added fonts to support all languages
- picodrive: partially rewrite package + re-enable for odroidc2
- Add alternative methods to detect sound cards
- Boot time optimization
- Wifi: option to change region added to gamestation.conf - with wifi.region=FR fixes channel 12 issue for example
- Old deprecated API removed, new API in development
- more informations in support archives
- sound: try to fix configuration loss on upgrade
- Add message to warn before turning off Gamestation
- Add Daphne system using Hypseus emulator
- pin356ONOFFRESET: improved behaviour, more compatible with nespi+ case
- Add splash screen duration option in gamestation.conf
- Bump mGBA emulator and add it to gb and gbc for Super Game Boy support
- Add Thomson TO + MO support with libretro core theodore, thank you zlika
- linapple: support apple2.configfile=dummy to avoid overwriting configuration
- Add Amstrad CPC core: crocods
- New version of libretro-o2em now supports save states and rewind
- Bump all libretro cores
- Bump Retroarch to 1.7.3 + patch required parts
- configgen: N64 back to fullscreen the real way, without forcing resolution
- configgen: the video syntax "auto DMT 4 HDMI" now works for N64

## [18.04.20] - 2018-04-20
- ES: Added pop-ups
- ES: Added tag in theme to force transition style
- Bump kodi-plugin-video-youtube to 5.4.6
- Bump Advancemame to 3.7 and spinner support added
- ES: Fixed audio card change
- fix: default font for ES and RA now in system
- ES: Added dynamic change of volume and audio output in menu
- ES: Added ubuntu_condensed.ttf as fallback font
- ES: Added clock in main menu
- ES: Added missing fav icons for Amigas 3DO and X68k
- ES: Fixed reload of theme when gamelistonly=0
- ES: Fixed HelpMessages not translated
- ES: Add "QUIT" help message on main menu
- revert PPSSPP version to previous one
- more informations in support archives
- upgrade: fix upgrading from custom branch to stable
- recallog now logs even when share is not mounted
- fix: wifi always activated on reboot even if disabled in ES
- split share detection and upgrade process
- mame2010: enable hiscores
- fix: fmsx could not be selected as a MSX core
- DosBox: resolve lag regression on RPI3 + strange behavior if no dosbox.bat
- SDL2: fix bug on x86 which stucks ScummVM on splash screen
- Odroid XU4: improved HDMI stability, boot.ini options
- fix: Game&Watch core name not properly displayed
- manager: update translations

## [18.03.30] - 2018-03-30
- moonlight: fix bad SDL2 GUID generation
- Odroid-xu4: remove screeching noise at fan startup
- configgen: fix videoconfig=auto
- ES: fix slow transition from last to first system
- Theme: various fix to gamestation-next
- manager: fix credentials and menu
- force the creation of a uuid file if it's missing

## [18.03.16] - 2018-03-16
- ES: new carousel mode ! Check UI Settings > Theme configuration with gamestation-next theme
- ES: no more whiste screen of death when VRAM is filled
- ES: new WiFi SSID selection box
- ES: also scan music subfolders
- ES: fix no music + wrong infos at boot
- ES: fix black screen once back from emulator
- ES: Kodi can only be started on the main systems screen
- segacd: add chd as supported file format
- sound: only set volume for playback devices
- psx: fixed typo (mu3 instead of m3u file extension)
- Moonlight: bump to 2.4.6, supports up to GFE 3.12 + can handle several GFE PC + rewrote scrape
- gamestation.conf videomode now supports a new auto mode
- ScummVM: Enable MT-32 emulation
- DosBox: bump to r4076 + add a virtual keyboard
- update the web manager (many fixes + many translations)
- ES: games can be started from the webmanager
- restored original splash video + added a few new ones, randomly played at boot
- fix mame platform
- PPSSPP: bump to 1.5.4
- gamestation.conf: add a new auto mode for videomode
- FBA Libretro: Bump to fix issues in some games
- x68000: fix the StartDir path to improve support for multidisks
- network: add the MUSIC keyword to network mounts

## [18.02.09] - 2018-02-09
- C2: disable picodrive for now until we fix compilation
- New system : amiga for pi2 and pi3
- Bump PPSSPP to 1.5.4
- Added mame2010 libretro core on all boards excepted rpi0/1
- X86: Added Nintendo DS support with libretro cores desmume and melonds
- Replaced intro video for christmas release
- Added ipega 9055 udev rule
- Added quirk for micreal arcade dual
- Added udev rule for the OUYA gamepad
- Wifi is now started before accessing network shares
- Added SHARP X68000 support with libretro core px68k, including publicly available bios files
- Added Panasonic 3DO (XU4 / X86) with libretro core 4do
- Odroid XU4: HDMI CEC disabled by default
- Add ResidualVM 0.4.0 as a new emulator for ScummVM system (rev. a98cca7)
- ScummVM: Allows to configure mapping of joystick buttons
- ScummVM: Bump to 2.0.0 + allows to configure mapping of joystick buttons
- DosBox: bump to r4067 (joystick configuration improvements) + enable IPX network
- pin356 script updated to add timer and short/long press to manage emulator exit and reset (reset only for RA)

- Odroid XU4: HDMI hot plug disabled by default

## [17.12.02] - 2017-12-02
- fixed steam controller service auto start, fixes lag in ES

## [17.12.01] - 2017-12-01
- solve erroneous logtime in recalbog.log
- updated gamestation-config.sh for wifi scan
- checkPackage: remove test case, new option to select packages to update
- X86: boot from USB HDD (was ok on x86_64)
- X86: Added 2 new PSX cores mednafen_psx and mednafen_psx_hw (enhanced version with OpenGL renderer)
- Cores: bumped libretro cores - first step
- Bumped retroarch to v1.6.9
- Bumped ScummVM
- Bumped DosBox to r4063
- Dreamcast: add a VMU to each connected pad
- Cores: bumped libretro cores - second step
- Bluemsx: bumped core to last version + added .cas/.m3u files support
- X86: added imlib2_grab to take command line screenshots
- X86: Added boot menu with verbose option
- Fix steam controller
- Arcade: updated dat and readme files
- N64: added mupen64plus GLideN64 video plugin on Odroid XU4 and C2
- On rpi Kodi now boots using the default screen resolution
- Retroarch: network commands fixed
- Fix wifi bug when several networks are configured

## [17.11.10.2] - 2017-11-10
- Fixed hyperion libraries

## [17.11.10] - 2017-11-10
- New pads : Nintendo Wii U and Switch Pro Controller, 8bitdo FC30 Arcade (BT and USB), Thrustmaster T Mini Wireless
- Pad: added Orange Controller default mapping
- scummvm: support the .scummvm extension directories. Still need the .scummvm file inside
- Added hyperion support
- Add usbhid quirk for [GamepadBlock](https://blog.petrockblock.com/gamepadblock/)
- Lynx: added libretro-handy core (by default)

## [17.11.02] - 2017-11-02
- add upgrade logs to the support archive
- bugfix: all bt pads were forced a udev rule
- increase BT detection time to 15s, log connect process
- use the right device GUID for PPSSPP
- now respect pad order in ES for PPSSPP
- force SDL2 retrarch input driver for moga pro
- moonlight: solve a configgen bug preventing from playing
- Switch to versionning based on YEAR.MONTH.DAY (17.10.21) for the gamestation released on October 21th 2017
- Fixed security option impossible to disable
- X86: added Marvell Wifi-Ex 8801 USB & Intel Wireless Bluetooth firmwares
- BlueMSX: changed default core-options (MSX2/60Hz/ym2413=enabled)
- Pad: added Moga Pro 2 HID default mapping


## [4.1.0] - 2017-10-13
- Pad: added Microsoft Xbox One S & Elite default mapping
- fix regression in splash video for pi
- BT: no more permanent background scan, just powerup hci0
- Splash video for Odroid XU4 and C2 + updated gamestation splash logo
- Snes9x_next: added a rule to enable multitap support only if there is at least 3 gamepads connected
- Bump virtual gamepad
- Add a script to easily update various package types
- PPSSPP: SNES-like pads can navigate in the menu + add retroarch-like combos
- X86: added xrandr to be able to manually manage video outputs
- X86: disabled screensaver (dpms)
- Commodore 64: added libretro-vice core (by default)
- X86: fixed issue that prevents retroarch shaders to work
- X86: fixed issue that stucks OpenGL on version 2.1
- Added DS4 and NES30 default config in es_inputs.cfg
- X86: now able to flash and boot x86 images on internal hard drive
- Updated libretro-cheats
- reicast: bump + fix RTC clock
- Bump retroarch to solve pad reordering issue
- psp: saves now go to the right folder
- Enhanced gliden64 video plugin configuration
- Pad : added FuSa GamePad Version 0.3 (PSP homebrew) default mapping
- Added noobs integration in archive images
- New review upgrade system 
- New video render for retroarch: dispmanx (pi only)
- Bumped Mupen64plus-GlideN64 video plugin to the Public Release 2.0
- Fixed joystick sensitivity issue with mupen64plus
- MAJOR BLUETOOTH CHANGE: users upgrading from 4.0 MUST PAIR AGAIN their controllers
- BT: add a manual fix for xiaomi gamepad
- deploys updates as docker containers
- fixed a BT scan bug
- bump configgen : remove moonlight config files before writing them + 5th moonlight player, remove commas in pad name
- BlueMSX: added F3/F4 buttons on gamepad
- BlueMSX: added .dsk files support
- Amstrad CPC (libretro-cap32 core): Fixed gamepads support + 2 players support + GUI menu
- fixed Nintendo Wiimote sending multiples events
- fix saving gamestation.conf when the same key exists multiple times
- Pad: add idroid default mapping
- added gamestation as default CEC name on rpi
- improve moonlight package
- rewrite usb quirks
- odroic c2: enable H264 hardware decoding
- xarcade: delay the startup of the driver
- xarcade: disable predefined combo keys
- remove unwanted Kodi plugins
- fix upgrade 4.0 -> 4.1 with the share on a FAT32 USB device 
- BT : improve startup, pairing and forgetting devices
- Add support for RPI0-W
- advancemame : bump to 3.4 and disable keyboard to prevent a crash when no keyboard is plugged
- Timezone change fixed
- increase the number of inodes for .img
- Better upgrade information
- Update CHANGELOG.md for nicer upgrade logs
- Show progression while downloading an update
- fix lynx core name
- appleII: fix known file extensions
- adding new kernel patch to support natively xinmo 20pins usb encoder
- fix webmanager2's dependencies
- fix sound regression since handling of multiple cards
- Fix muted sound on boot
- samba: definitely remove printer support
- improve CI output + better error logging on failed build
- fix gamecon 1.2
- configgen: scummvm: added fullscreen option
- configgen: libretroConfig.py: would crash when retroarchcustom.cfg didn't exist
- configgen: added n64 to systems not supporting rewind
- configgen: Fix PPSSPP for any pad
- gamestation-manager2: add new locales, stop and restart ES works again
- Solve a bug on .img compression
- Automatically update XBox360 pads configuration for ES
- Force a 2GB root size for .img
- Compress .img in xz
- Don't forget bluetooth paired devices on upgrade
- Proper restart of Emulationstation
- add locales to gamestation-manager2
- Improve sound management when running multiple sound cards
- Bumped gamestation-manager2 to v2.0
- Carefully compare versions to verify if an update is available
- Add a generic SNES pad configuration
- Add Logitech F310 Direct Input mode configuration
- Add Logitech F310 XInput mode (which is recommended) configuration
- Upgrade retroarch config files
- Added Latvian support
- Added Luxembourgish support
- fix missing roms + configs subfolders creation
- fix gamestation.conf not being upgraded
- improve BT connectivity
- fixed black screen on systems with new configgen version
- added Czech language support
- run v2 of manager if version not found in gamestation.conf
- fixed emulationstation.forcebasicgamelistview
- add tft waveshare 3.2 and 3.5 overlays + fbcp program to support them
- add pwm-audio-pi-zero overlay to get audio thanks to PWMs through GPIO Pins 18 and 13 on an Pi Zero equivalent to dtoverlay=pwm-2chan,pin=18,func=2,pin2=13,func2=4
- new web manager
- add pwm-audio-pi-zero overlay to get audio thanks to PWMs through GPIO Pins 18 and 13 on an Pi Zero equivalent to dtoverlay=pwm-2chan,pin=18,func=2,pin2=13,func2=4
- add rgb-pi overlay
- fixed rgb-pi overlay
- checksum on upgrades, progression percentage much more accurate
- Bump to Bump rpi-userland 8e84b9003d8259472f9c79b385443b1b4975203e and rpi-firmware b365edad4e75126fb9bfee2325652758407e4f74 to change be able to change video résolution on the fly via the vcgencmd command. This will be very useful the get pixel perfect on rgb screen
- Fixing BT firmware copy for Realtek BT devices (81xx 87xx and 88xx)
- Fixing Makelfiles for compilation of libretro-lutro for the bump to release 2377dd37ad3bd37ddef9fc37742bba2531a78407
- Bump retroarch to last release due to integration of libretro-imageviewer in its cores, and delation of the libretro-imageviewer repos
- Update Mame2003 core to get the mame2003-skip_warnings and avoid splash screen
- New emulator : PPSSPP
- Add Mayflash NES/SNES and SEGA SATURN in usbhid.conf
- Added omxplayer to enable Introduction video
- Updated gamestation-configgen to version 4.1.X
- Added linapple-pie to gamestation-rpi3_defconfig
- Added support for vice 2.4.24. This means support for commodore c64 and other commodore systems
- Added theme for commodore c64
- Added two demo ROMs for commodore c64
- Add linapple specific parameters to start fixing an issue.
- Added user's configuration files upgrade
- Merged buildroot upstream
- Added retroachievements hardcore mode
- Add omxplayer to rpi2 & rpi3 defconfig
- Add Kodi default plugins/repositories
- Improved S02splash script for video splash
- linapple-pie download redirected to LaurentMarchelli
- passed to gcc5
- Added pgrep to busybox for omxplayer extensions
- New video version and splash video now stopped when kodi is started
- Added custom ratio per game option
- Dbus implementation to have fade out effect on splash video
- Added Witty Pi powerswitch support with Wiring Pi.
- Network connection manager : ethernet configuration on wire connection
- Network connection manager : multiple wifi configurations
- Wifi : open/wep/wpa/wpa2
- New emulator : reicast
- Bumped retroarch to v1.3.4
- Added retroachievements support to fceunext core
- Reicast : add multiplayer support
- Bump moonlight-embedded to 2.2.3, adds support for GFE 3.3
- Added enet library for moonlight-embedded-2.2.0
- Solved a bug on xarcade where B and HOTKEY were sending the same event
- Slide transition by default in ES
- Power management switch support (power,reset and LED) for pin 3/5/6
- Add ifconfig -a and /boot/gamestation-boot.conf in gamestation-support.sh
- S99Custom now trasmits its init parameter to custom.sh
- Add ipega 9021 rules
- ES now shutdowns the system
- share/roms/saves/bios available via a network point
- bumped SDL to 2.0.4
- disable multitouch axis in SDL 2.0.4
- linux kernel bumped to 4.4.13
- Add new Traditional Chinese Language
- Add DosBox 0.74 (rev 3989) with specific patches: SDL2, with mapping of mouse and all axis of joysticks
- Add lutro extension
- Add a gamestation.conf option to set a video mode only for es
- Add Catalan translation
- Check space left before update
- Added ColecoVison support to bluemsx libretro core
- Added the alternative N64 core GLupeN64 on rpi2/rpi3
- Added IPF format support to libretro-hatari (atarist ST)
- Reenable mp3 support for SDL2 mixer.
- Updated libretro-fba core from FBA 0.2.97.37 to FBA 0.2.97.39
- Added Mad Catz C.T.R.L.R udev rules
- Add configs to gamestation-support.sh
- Add firmwares ASUS BT400 and Qualcomm Atheros AR3011 BT3.0
- S50dropbear kills existing SSH connection at stop
- Add support for PS4 Dualshock4 bluetooth controllers
- Updated gamecon driver from 1.0 to 1.2
- Solve the loading of the DB9 driver
- N64 configgen shouldn't crash anymore if some keys are not mapped
- Add xin-mo 20pins players and ipega 9028
- Add new languages : arabic dutch greek korean norwegian norwegian bokmål polish
- Support PI3 internal bluetooth via bluez5
- Add USB PS2 : GreenAsia Electronics
- PSX: .bin extentions removed (use .cue instead)
- Enable highscores for fba_libretro
- Add mame parent only dat file
- Add ipega pg 9055 rules
- Add mame parent only dat file 
- Add xin-mo 18pin, mayflash N64 and correction usbhid
- Add usbhid for Retrobit Genesis to PC USB Adapter
- new arcade emulator: AdvanceMame
- 7z support for fba_libretro
- Synced with buildroot 2016.11 
- Added GNU diffutils
- Now shows changelog when updating the system
- Added snes9x libretro core (MSU-1 support)
- Patched xpad driver to support Xbox One S / Elite controllers in USB mode
- Patched xpad driver to fix the blinking xbox leds
- Build on gitlab ci
- Added emulationstation.hidesystemview option in gamestation.conf to hide system view
- Added emulationstation.selectedsystem option in gamestation.conf to select a system on boot
- Added emulationstation.bootongamelist to boot on the system gamelist
- Added emulationstation.gamelistonly to improve boot time
- Bumped libretro cores on last version
- Added Japanese, Russian and Hungarian languages
- Bumped virtualgamepads version - virtualkeyboard now available
- Add usb encoder 3H-Dual-Arcade, Mayflash dreamcast adapter
- Added "Joe Contre Les Pharaons" Amstrad CPC homebrew
- Added RPI3 overclock presets + warning popup if TURBO/EXTREM
- Add support for smb and upnp protocols in Kodi
- Removed xboxdrv driver - broken since kernel's bump
- Deactivated rumble support in pcsx core - causes endless vibrations problems
- Bumped pcsx core - added an option to enable bios splashscreeen (may broke some games - disabled by default)
- Add usbhid quirk for AJ 2 USB 2.4G sans fil manettes (ShanWan Twin USB Joystick PS3)
- Added ScummVM on X86, X86_64, odroid c2 and odroid xu4

## [4.0.0-beta5] - 2016-08-13hs the ratio issue in mame.
- Improved pads and gpio support for moonlight
- Change location of PM2_HOME to fix a bug with API daemon
- Disable printer sharing to reduce log output
- Prevent MacOS from adding its .DS_store

## [4.0.0-beta4] - 2016-06-19
- Update to moonlight-embedded-2.2.1 (but still displays 2.2.0 when running), adds support for GFE 2.11
- Added enet library for moonlight-embedded-2.2.0
- Solved a bug on xarcade where B and HOTKEY were sending the same event
- Slide transition by default in ES
- Power management switch support (power,reset and LED) for pin 3/5/6
- Add ifconfig -a and /boot/gamestation-boot.conf in gamestation-support.sh
- S99Custom now trasmits its init parameter to custom.sh
- Bumped retroarch to v1.3.4
- Add ipega 9021 rules
- Added stat in busybox
- Added integer scale (Pixel Perfect) option

## [4.0.0-beta3] - 2016-04-19
- Xarcade2jstick button remapped + better support of IPAC encoders
- Added IPAC2 keyboard encoder
- Patched xpad driver to support Xbox One controllers in USB mode
- Updated gamepads inputs to support moonlight
- Fix some kodi bugs about joysticks
- Added OpenGL + scalers supports to scummvm
- Power management switch support for pin 5/6
- Fix freeze issue with libretro-mgba core
- Added megatools
- Added new gamestation 4.0.0 systems
- Added crt-pi shaders
- Fix Namco/Taito games in mame2003
- Added kempston joystick by default for zxspectrum
- Updated scummvm to version 1.8
- Added VIM
- Added gamestation-themes package
- Gamestation theme by default

## [4.0.0-beta2]
- Added rpi3 support (without bluetooth)
- Added support for power management boards
- Added rpi gpio and wiringpi
- Added OOB remote controls
- Fixed keyboard issue in ES
- Fixed retroachievement support on picodrive and fceumm libretro cores
- Fixed system locales
- Updated 8bitdo gamepads
- Bumped to moonlight-embedded-2.1.4
- Overclock set to none now delete lines in config.txt 
- Improved keyboard encoders support
- Fixed an issue concerning ISO loading taking too long

## [4.0.0-beta1]
- new update process
- new languages
- external storage choice
- favourite system

## [3.3.0-beta17]
- New version of xboxdrv
- Corrected 8bitdo mapping
- Added wiringpi
- switch USBHID to kernel module for gamepad encoders
- linapple-pie (Apple ][ Emulator) added to rpi2, rpi1 need to be tested

## [3.3.0-beta16] - 2015-11-24
- Corrected kodi start
- Bumped to moonlight-embedded-2.1.2

## [3.3.0-beta15] - 2015-11-22
- Corrected sound issues with IREM games on libretro-mame2003 core
- Updated libretro-fba core from FBA 0.2.97.36 to FBA 0.2.97.37
- Added gamestation api
- Added Chinese and Turkish
- Added samba switch in gamestation.conf
- Added WiiMote support
- Added Kodi controller support 
- Corrected controller <-> player attribution
- Added moonlight system support, with roms
- Added new switch in gamestation.conf for ssh and virtual gamepads

## [3.3.0-beta14] - 2015-11-01
- Corrected gamestation manager

## [3.3.0-beta13] - 2015-11-01
- Added gamestation-manager
- Added custom ratio support

## [3.3.0-beta12] - 2015-10-31
- Added EmulationStation shutdown screen
- Corrected select to quit shortcut

## [3.3.0-beta11] - 2015-10-31
- Corrected shadersets bug

## [3.3.0-beta10] - 2015-10-31
- Added GLideN64 video plugin
- Added mame2003 libretro as default mame emulator
- Added system.emulators.specialkeys to select the emulators special keys functions
- Updated snes9x core (fix the bomberman 5 freeze)
- Added Saitek controllers support
- Added select shortcut in menu for quick restart / shutdown
- Added Basque language

## [3.3.0-beta9] - 2015-10-11
- Fixed Moonlight theme for zoid
- Added splashscreen for long reboots
- Added mplayer and jscal 
- Updated atari 2600 stella core for 2 players support
- Updated fba libretro for R3 diag menu
- Added xbox 360 official wireless dongle support OOTB
- Added fullscreen/ratio/widescreen hack settings for n64

## [3.3.0-beta8] - 2015-10-06
- Removed avahi daemon
- Fixed Moonlight theme

## [3.3.0-beta7] - 2015-09-20
- Updated themes + added moonlight themes
- Updated .dat and infos about fba_libretro romset
- Updated gamestation.conf with list of cores not supporting rewind
- Added system.es.menu option
- Added Moonlight
- Added kodi webserver on port 8081
- Added auto-connection for bluetooth controllers

## [3.3.0-beta6] - 2015-09-15
- More 8bitdo support
- Corrected retro shaderset for mastersystem
- Corrected kodi autostart

## [3.3.0-beta5] - 2015-09-13
- Added scanlines and retro shadersets
- Added name based sdl2 driver switch (8bitdo support)
- Added cavestory support
- Added mad and vorbis support in scummvm
- Refactored ES gamestation.conf management

## [3.3.0-beta4] - 2015-09-05
- Corrected start kodi with X
- Added NES30 Pro Support
- Added SFC30 Support
- Ignore cheats for updates

## [3.3.0-beta3] - 2015-08-29
- Added xiaomi bluetooth controller config
- Added default videomode that doesn't change the resolution while launching games
- Added 16/10 support and 16/10 is set as default for wswan
- Added gamestation version of Virtual Gamepad
- Added retroarch input driver autoconfig based on guid
- Added doom 1 shareware

## [3.3.0-beta2] - 2015-08-23
- Changed update repo and system

## [3.3.0-beta1] - 2015-08-22
- Added Wonderswan Color libretro emulator
- Added Lutro libretro core (LUA framework)
- Added NeoGeo as a separated system
- Added NeoGeo Pocket Color libretro emulator
- Added Vectrex libretro emulator
- Added Game And Watch libretro emulator
- Added Lynx libretro emulator
- Added PRBoom libretro 
- Modif zoid theme
- Patched kernel to support retrobit controllers
- Patched kernel to support 4NES4SNES controllers
- Patched kernel to fix the blinking xbox led. Only on rpi2
- Added gpu_mem for 256mo rpi1
- Unified the branches rpi and rpi2
- Updated buildroot sources
- Added libretro cheats
- Added favorites to emulationstation (from kaptainkia es modifications)
- Added mk_arcade_joystick_rpi with one more button
- Added adafruit-retrogame utility
- Added gamestation-configgen support
- Added sixad driver choice
- Added SuperGrafx libretro emulator
- Added NXengine libretro core (cavestory)
- Added Atari 7800 libretro emulator
- Added hostname in gamestation.conf
- Added gamestation-system (gamestation.arch file)
- Changed bash as default shell
- Corrected update system
- Added Tgbdual libretro core
- Added Miroof's Virtual Gamepads
- Added silent install
 
## [3.2.11] - 2015-03-24
- Corrected issues with controllers with idientical names
- Added zoid theme

## [3.2.10] - 2015-03-17
- Corrected itialian translation
- Recompiled modules for 3.19

## [3.2.9] - 2015-03-15
### Changed
- Added fba emulator switch
- Added snes9x, catsfc, pocketsnes switch 
- Added virtualboy platform
- Fixed : buttons on axis in retroarch config
- Added timestamps in logs
- Fixed xboxdrv pacakge
- Bumbep to Kodi-14.2-rc1
- Added clrmame info and dat files for mame and fba
- Added fbalibretro system
- Added italian translation

## [3.2.8] - 2015-03-09
### Changed
- Added switches in gamestation.conf
    - kodi x button switch
    - game resolution switch
    - update check switch
    - xboxdrv switch
    - localtime switch
- Fixed : mupen rice plugin package
- Fixed : xboxdrv pacakge
- Added localtime support
- Added mgd extension for snes
- Fixed : L2 + R2 mapping in retroarch
- Fixed : only axis based joystick configuration
- Changed all package to specific versions
- Bumped to 3.19 for rpi2
- Bumped to last userland and firmware
- Kodi PVR support
- Added cifs support
- Added ipv6 support
- Fixed : hats for specials key on retroarch

## [3.2.7] - 2015-03-03
- Fixed boot process

## [3.2.6] - 2015-03-03
### Changed
- Added z64 extenson for n64
- Added xbox360 wireless defaut configuration
- Fixed : power management of ew-7811un
- Added kodi mysql support
- Fixed nfs startup script

## [3.2.5] - 2015-03-03
### Changed
- Added samba socket option for large files copy
- Added db9 driver package
- Added gamecon driver package
- Added new setting configuration file (gamestation.conf)
- Added new startup system
- Fixed : ssid with space from emulationstation
- Fixed : ntfs automount