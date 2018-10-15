#!/bin/bash -e

echo ok
curl -vL https://github.com/gamestation/gamestation-rescue/releases/download/v4.1.0/gamestation-rescue-4.1.0.tar.xz > gamestation-rescue-4.1.0.tar.xz
xz -d gamestation-rescue-4.1.0.tar.xz

mkdir gamestation-rescue-4.1.0
tar vfx gamestation-rescue-4.1.0.tar -C gamestation-rescue-4.1.0

cd gamestation-rescue-4.1.0

for rpi in rpi1 rpi2 rpi3; do
  curl -vfL https://archivev2.gamestation.com/v1/upgrade/${rpi}/boot.tar.xz > os/gamestationOS-${rpi}/boot.tar.xz
  curl https://archivev2.gamestation.com/v1/upgrade/rpi1/boot.tar.xz.sha1 > os/gamestationOS-${rpi}/boot.tar.xz.sha1
  [[ "$(cat os/gamestationOS-${rpi}/boot.tar.xz.sha1 | awk '{print $1}')" != "$(sha1sum os/gamestationOS-${rpi}/boot.tar.xz)" ]] && exit 1

  curl -vfL https://archivev2.gamestation.com/v1/upgrade/${rpi}/root.tar.xz > os/gamestationOS-${rpi}/root.tar.xz
  curl https://archivev2.gamestation.com/v1/upgrade/rpi1/root.tar.xz.sha1 > os/gamestationOS-${rpi}/root.tar.xz.sha1
  [[ "$(cat os/gamestationOS-${rpi}/root.tar.xz.sha1 | awk '{print $1}')" != "$(sha1sum os/gamestationOS-${rpi}/root.tar.xz)" ]] && exit 1
done

zip -r gamestation-final-all-rpi.zip *
