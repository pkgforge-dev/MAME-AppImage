#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q mame | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export DESKTOP=/usr/share/applications/mame.desktop
export ICON=/usr/share/icons/hicolor/scalable/apps/mame.svg
export DEPLOY_OPENGL=1
export DEPLOY_PIPEWIRE=1
export DEPLOY_QT=1

# Deploy dependencies
quick-sharun \
  /usr/lib/mame/mame                       \
  /usr/lib/gio/modules/libdconfsettings.so \
  /usr/lib/libdecor/*/libdecor-cairo.so
  
cp -rvn /usr/lib/mame/* ./AppDir/bin

# turn appdir into appimage
quick-sharun --make-appimage

echo "All Done!"
