#!/bin/sh

set -eu
EXTRA_PACKAGES="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/get-debloated-pkgs.sh"
PACKAGE_BUILDER="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/make-aur-package.sh"

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
wget --retry-connrefused --tries=30 "$PACKAGE_BUILDER" -O ./make-aur-package.sh
chmod +x ./make-aur-package.sh
./make-aur-package.sh mame

pacman -Q mame | awk '{print $2; exit}' > ~/version
