#!/bin/bash -e

# PWD = source dir
# BASE_DIR = build dir
# BUILD_DIR = base dir/build
# HOST_DIR = base dir/host
# BINARIES_DIR = images dir
# TARGET_DIR = target dir

# XU4 SD/EMMC CARD
#
#       1      31      63          719     1231    1263
# +-----+-------+-------+-----------+--------+-------+--------+----------+--------------+
# | MBR |  bl1  |  bl2  |   uboot   |  tzsw  | erase |  BOOT  |  ROOTFS  |     FREE     |
# +-----+-------+-------+-----------+--------+-------+--------+----------+--------------+
#      512     15K     31K         359K     615K    631K     64M        1.2G
#
# http://odroid.com/dokuwiki/doku.php?id=en:xu3_partition_table
# https://github.com/hardkernel/u-boot/blob/odroidxu3-v2012.07/sd_fuse/hardkernel/sd_fusing.sh

xu4_fusing() {
    BINARIES_DIR=$1
    GAMESTATIONIMG=$2

    # fusing
    signed_bl1_position=1
    bl2_position=31
    uboot_position=63
    tzsw_position=719
    env_position=1231

    echo "BL1 fusing"
    dd if="${BINARIES_DIR}/bl1.bin.hardkernel"    of="${GAMESTATIONIMG}" seek=$signed_bl1_position conv=notrunc || return 1

    echo "BL2 fusing"
    dd if="${BINARIES_DIR}/bl2.bin.hardkernel"    of="${GAMESTATIONIMG}" seek=$bl2_position        conv=notrunc || return 1

    echo "u-boot fusing"
    dd if="${BINARIES_DIR}/u-boot.bin.hardkernel" of="${GAMESTATIONIMG}" seek=$uboot_position      conv=notrunc || return 1

    echo "TrustZone S/W fusing"
    dd if="${BINARIES_DIR}/tzsw.bin.hardkernel"   of="${GAMESTATIONIMG}" seek=$tzsw_position       conv=notrunc || return 1

    echo "u-boot env erase"
    dd if=/dev/zero of="${GAMESTATIONIMG}" seek=$env_position count=32 bs=512 conv=notrunc || return 1
}

# C2 SD CARD
#
#       1       97         1281
# +-----+-------+-----------+--------+----------+--------------+
# | MBR |  bl1  |   uboot   |  BOOT  |  ROOTFS  |     FREE     |
# +-----+-------+-----------+--------+----------+--------------+
#      512     48K         640K
#
# http://odroid.com/dokuwiki/doku.php?id=en:c2_building_u-boot

c2_fusing() {
    BINARIES_DIR=$1
    GAMESTATIONIMG=$2

    # fusing
    signed_bl1_position=1
    signed_bl1_skip=0
    uboot_position=97

    echo "BL1 fusing"
    dd if="${BINARIES_DIR}/bl1.bin.hardkernel" of="${GAMESTATIONIMG}" seek=$signed_bl1_position skip=$signed_bl1_skip conv=notrunc || return 1

    echo "u-boot fusing"
    dd if="${BINARIES_DIR}/u-boot.bin"         of="${GAMESTATIONIMG}" seek=$uboot_position                            conv=notrunc || return 1
}

GAMESTATION_BINARIES_DIR="${BINARIES_DIR}/gamestation"
GAMESTATION_TARGET_DIR="${TARGET_DIR}/gamestation"

if [ -d "${GAMESTATION_BINARIES_DIR}" ]; then
    rm -rf "${GAMESTATION_BINARIES_DIR}"
fi

mkdir -p "${GAMESTATION_BINARIES_DIR}"

# XU4, RPI0, RPI1, RPI2 or RPI3
GAMESTATION_TARGET=$(grep -E "^BR2_PACKAGE_GAMESTATION_TARGET_[A-Z_0-9]*=y$" "${BR2_CONFIG}" | sed -e s+'^BR2_PACKAGE_GAMESTATION_TARGET_\([A-Z_0-9]*\)=y$'+'\1'+)

echo -e "\n----- Generating images/gamestation files -----\n"

case "${GAMESTATION_TARGET}" in
    RPI0|RPI1|RPI2|RPI3)
	# root.tar.xz
	cp "${BINARIES_DIR}/rootfs.tar.xz" "${GAMESTATION_BINARIES_DIR}/root.tar.xz" || exit 1

	# boot.tar.xz
	cp -f "${BINARIES_DIR}/"*.dtb "${BINARIES_DIR}/rpi-firmware"
	cp "${BINARIES_DIR}/zImage" "${BINARIES_DIR}/rpi-firmware/zImage"
	tar -cJf "${GAMESTATION_BINARIES_DIR}/boot.tar.xz" -C "${BINARIES_DIR}/rpi-firmware" "." ||
	    { echo "ERROR : unable to create boot.tar.xz" && exit 1 ;}

	# gamestation.img
	GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"
	GAMESTATIONIMG="${GAMESTATION_BINARIES_DIR}/gamestation.img"
	rm -rf "${GENIMAGE_TMP}" || exit 1
	cp "${BR2_EXTERNAL_GAMESTATION_PATH}/board/gamestation/rpi/genimage.cfg" "${BINARIES_DIR}/genimage.cfg.tmp" || exit 1
	FILES=$(find "${BINARIES_DIR}/rpi-firmware" -type f | sed -e s+"^${BINARIES_DIR}/rpi-firmware/\(.*\)$"+"file \1 \{ image = 'rpi-firmware/\1' }"+ | tr '\n' '@')
	cat "${BINARIES_DIR}/genimage.cfg.tmp" | sed -e s+'@files'+"${FILES}"+ | tr '@' '\n' > "${BINARIES_DIR}/genimage.cfg" || exit 1
	rm -f "${BINARIES_DIR}/genimage.cfg.tmp" || exit 1
	genimage --rootpath="${TARGET_DIR}" --inputpath="${BINARIES_DIR}" --outputpath="${GAMESTATION_BINARIES_DIR}" --config="${BINARIES_DIR}/genimage.cfg" --tmppath="${GENIMAGE_TMP}" || exit 1
	rm -f "${GAMESTATION_BINARIES_DIR}/boot.vfat" || exit 1
	sync || exit 1
	;;

    XU4)
	# dirty boot binary files
	for F in bl1.bin.hardkernel bl2.bin.hardkernel tzsw.bin.hardkernel u-boot.bin.hardkernel
	do
	    cp "${BUILD_DIR}/uboot-odroidxu3-v2012.07/sd_fuse/hardkernel/${F}" "${BINARIES_DIR}" || exit 1
	done

	# /boot
	cp "${BR2_EXTERNAL_GAMESTATION_PATH}/board/gamestation/xu4/boot.ini" ${BINARIES_DIR}/boot.ini || exit 1

	# root.tar.xz
	cp "${BINARIES_DIR}/rootfs.tar.xz" "${GAMESTATION_BINARIES_DIR}/root.tar.xz" || exit 1

	# boot.tar.xz
	(cd "${BINARIES_DIR}" && tar -cJf "${GAMESTATION_BINARIES_DIR}/boot.tar.xz" boot.ini zImage exynos5422-odroidxu3.dtb gamestation-boot.conf) || exit 1

	# gamestation.img
	GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"
	GAMESTATIONIMG="${GAMESTATION_BINARIES_DIR}/gamestation.img"
	rm -rf "${GENIMAGE_TMP}" || exit 1
	cp "${BR2_EXTERNAL_GAMESTATION_PATH}/board/gamestation/xu4/genimage.cfg" "${BINARIES_DIR}" || exit 1
	genimage --rootpath="${TARGET_DIR}" --inputpath="${BINARIES_DIR}" --outputpath="${GAMESTATION_BINARIES_DIR}" --config="${BINARIES_DIR}/genimage.cfg" --tmppath="${GENIMAGE_TMP}" || exit 1
	rm -f "${GAMESTATION_BINARIES_DIR}/boot.vfat" || exit 1
	xu4_fusing "${BINARIES_DIR}" "${GAMESTATIONIMG}" || exit 1
	sync || exit 1
	;;

    C2)
	# dirty boot binary files
	for F in bl1.bin.hardkernel u-boot.bin
	do
	    cp "${BUILD_DIR}/uboot-odroidc2-v2015.01/sd_fuse/${F}" "${BINARIES_DIR}" || exit 1
	done
	cp "${BR2_EXTERNAL_GAMESTATION_PATH}/board/gamestation/c2/boot-logo.bmp.gz" ${BINARIES_DIR} || exit 1

	# /boot
	cp "${BR2_EXTERNAL_GAMESTATION_PATH}/board/gamestation/c2/boot.ini" ${BINARIES_DIR}/boot.ini || exit 1

	# root.tar.xz
	cp "${BINARIES_DIR}/rootfs.tar.xz" "${GAMESTATION_BINARIES_DIR}/root.tar.xz" || exit 1

	# boot.tar.xz
	(cd "${BINARIES_DIR}" && tar -cJf "${GAMESTATION_BINARIES_DIR}/boot.tar.xz" boot.ini Image meson64_odroidc2.dtb gamestation-boot.conf boot-logo.bmp.gz) || exit 1

	# gamestation.img
	GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"
	GAMESTATIONIMG="${GAMESTATION_BINARIES_DIR}/gamestation.img"
	rm -rf "${GENIMAGE_TMP}" || exit 1
	cp "${BR2_EXTERNAL_GAMESTATION_PATH}/board/gamestation/c2/genimage.cfg" "${BINARIES_DIR}" || exit 1
	genimage --rootpath="${TARGET_DIR}" --inputpath="${BINARIES_DIR}" --outputpath="${GAMESTATION_BINARIES_DIR}" --config="${BINARIES_DIR}/genimage.cfg" --tmppath="${GENIMAGE_TMP}" || exit 1
	rm -f "${GAMESTATION_BINARIES_DIR}/boot.vfat" || exit 1
	c2_fusing "${BINARIES_DIR}" "${GAMESTATIONIMG}" || exit 1
	sync || exit 1
	;;

      X86|X86_64)
	# /boot
	rm -rf ${BINARIES_DIR}/boot || exit 1
	mkdir -p ${BINARIES_DIR}/boot/grub || exit 1
	cp "${BR2_EXTERNAL_GAMESTATION_PATH}/board/gamestation/grub2/grub.cfg" ${BINARIES_DIR}/boot/grub/grub.cfg || exit 1
	cp "${BINARIES_DIR}/bzImage" "${BINARIES_DIR}/boot" || exit 1
	cp "${BINARIES_DIR}/initrd.gz" "${BINARIES_DIR}/boot" || exit 1

	# root.tar.xz
	cp "${BINARIES_DIR}/rootfs.tar.xz" "${GAMESTATION_BINARIES_DIR}/root.tar.xz" || exit 1

	# get UEFI files
	mkdir -p "${BINARIES_DIR}/EFI/BOOT" || exit 1
	cp "${BINARIES_DIR}/bootx64.efi" "${BINARIES_DIR}/EFI/BOOT" || exit 1
	cp "${BR2_EXTERNAL_GAMESTATION_PATH}/board/gamestation/grub2/grub.cfg" "${BINARIES_DIR}/EFI/BOOT" || exit 1

	# boot.tar.xz
	(cd "${BINARIES_DIR}" && tar -cJf "${GAMESTATION_BINARIES_DIR}/boot.tar.xz" EFI boot gamestation-boot.conf) || exit 1

	# gamestation.img
	GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"
	GAMESTATIONIMG="${GAMESTATION_BINARIES_DIR}/gamestation.img"
	rm -rf "${GENIMAGE_TMP}" || exit 1
	cp "${BR2_EXTERNAL_GAMESTATION_PATH}/board/gamestation/grub2/genimage.cfg" "${BINARIES_DIR}" || exit 1
        cp "${HOST_DIR}/usr/lib/grub/i386-pc/boot.img" "${BINARIES_DIR}" || exit 1
	genimage --rootpath="${TARGET_DIR}" --inputpath="${BINARIES_DIR}" --outputpath="${GAMESTATION_BINARIES_DIR}" --config="${BINARIES_DIR}/genimage.cfg" --tmppath="${GENIMAGE_TMP}" || exit 1
	rm -f "${GAMESTATION_BINARIES_DIR}/boot.vfat" || exit 1
	sync || exit 1
	;;
    *)
	echo "Outch. Unknown target ${GAMESTATION_TARGET} (see copy-gamestation-archives.sh)" >&2
	bash
	exit 1
esac

# Compress the generated .img
if [[ -f ${GAMESTATION_BINARIES_DIR}/gamestation.img ]] ; then
    echo "Compressing ${GAMESTATION_BINARIES_DIR}/gamestation.img ... "
    xz "${GAMESTATION_BINARIES_DIR}/gamestation.img"
fi

# Computing hash sums to make have an update that can be dropped on a running Gamestation
echo "Computing sha1 sums ..."
for file in "${GAMESTATION_BINARIES_DIR}"/* ; do sha1sum "${file}" > "${file}.sha1"; done
tar tf "${GAMESTATION_BINARIES_DIR}/root.tar.xz" | sort > "${GAMESTATION_BINARIES_DIR}/root.list"