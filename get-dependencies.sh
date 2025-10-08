#!/bin/sh

set -ex
ARCH="$(uname -m)"
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
./get-debloated-pkgs.sh --add-opengl libxml2-mini opus-mini qt6-base-mini gdk-pixbuf2-mini

echo "Building MAME..."
echo "---------------------------------------------------------------"
sed -i -e 's|EUID == 0|EUID == 69|g' /usr/bin/makepkg
sed -i \
	-e 's|-O2|-O3|'                              \
	-e 's|MAKEFLAGS=.*|MAKEFLAGS="-j$(nproc)"|'  \
	-e 's|#MAKEFLAGS|MAKEFLAGS|'                 \
	/etc/makepkg.conf
cat /etc/makepkg.conf

git clone --depth 1 https://gitlab.archlinux.org/archlinux/packaging/packages/mame.git ./mame && (
	cd ./mame
	sed -i -e "s|x86_64|$ARCH|" ./PKGBUILD
	makepkg -fs --noconfirm --skippgpcheck
	ls -la .
	pacman --noconfirm -U ./*.pkg.tar.*
)

pacman -Q mame | awk '{print $2; exit}' > ~/version
