#!/bin/sh

set -ex

EXTRA_PACKAGES="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/get-debloated-pkgs.sh"

echo "Installing dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
	base-devel        \
	cmake             \
	dconf             \
	ccache            \
	curl              \
	git               \
	libdecor          \
	libx11            \
	libxrandr         \
	libxss            \
	mame              \
	pipewire-audio    \
	pulseaudio        \
	pulseaudio-alsa   \
	sdl2              \
	wget              \
	xorg-server-xvfb  \
	zlib              \
	zsync

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
wget --retry-connrefused --tries=30 "$EXTRA_PACKAGES" -O ./get-debloated-pkgs.sh
chmod +x ./get-debloated-pkgs.sh
./get-debloated-pkgs.sh --add-opengl libxml2-mini opus-mini qt6-base-mini

pacman -Q mame | awk '{print $2; exit}' > ~/version
