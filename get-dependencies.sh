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
make-aur-package mame
