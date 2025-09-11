#!/bin/sh

set -ex

ARCH="$(uname -m)"
VERSION="$(cat ~/version)"

# NOW MAKE APPIMAGE
URUNTIME="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/uruntime2appimage.sh"
SHARUN="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/quick-sharun.sh"

export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export OUTNAME=MAME-"$VERSION"-anylinux-"$ARCH".AppImage
export DESKTOP=/usr/share/applications/mame.desktop
export ICON=/usr/share/icons/hicolor/scalable/apps/mame.svg
export DEPLOY_OPENGL=1
export DEPLOY_PIPEWIRE=1
export DEPLOY_QT=1

# ADD LIBRARIES
wget --retry-connrefused --tries=30 "$SHARUN" -O ./quick-sharun
chmod +x ./quick-sharun
./quick-sharun /usr/lib/mame/mame /usr/lib/gio/modules/libdconfsettings.so /usr/lib/libdecor/*/libdecor-cairo.so

cp -rvn /usr/lib/mame/* ./AppDir/bin

# turn appdir into appimage
wget --retry-connrefused --tries=30 "$URUNTIME" -O ./uruntime2appimage
chmod +x ./uruntime2appimage
./uruntime2appimage

mkdir -p ./dist
mv -v ./*.AppImage* ./dist
mv -v ~/version     ./dist

echo "All Done!"
