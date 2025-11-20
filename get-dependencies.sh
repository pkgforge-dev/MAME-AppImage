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
gpg --recv-keys 79BE3E4300411886
make-aur-package --archlinux-pkg mame
