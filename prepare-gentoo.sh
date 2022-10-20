#!/bin/sh

SUDO=sudo

# Check if using doas
if command -v doas &> /dev/null ; then
	SUDO=doas
fi

# Install build dependencies
$SUDO emerge $@ --ask --noreplace \
  net-misc/wget dev-vcs/git dev-python/pip sys-apps/fakeroot \
  app-arch/libarchive app-crypt/gpgme sys-devel/bison sys-devel/flex\
  dev-libs/mpc dev-libs/libusb-compat
