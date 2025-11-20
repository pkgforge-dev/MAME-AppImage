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
gpg --recv-keys C174B1018C40710E
make-aur-package --archlinux-pkg mame
