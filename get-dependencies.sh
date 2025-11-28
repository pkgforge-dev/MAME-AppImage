#!/bin/sh

set -eu

echo "Installing dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
	cmake             \
	dconf             \
	ccache            \
	libdecor          \
	pipewire-audio    \
	sdl2              \
	zsync

echo "Building MAME..."
echo "---------------------------------------------------------------"
pacman -Rns archlinux-keyring && pacman -S archlinux-keyring && pacman-key --init && pacman-key --populate
sed -i -e 's|--skippgpcheck||g' "$(command -v make-aur-package)"
make-aur-package --archlinux-pkg mame
