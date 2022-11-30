#!/bin/bash

# Install build dependencies
sudo dnf install $@ \
  @development-tools gcc gcc-c++ g++ wget git autoconf automake python3 python3-pip make cmake pkgconf fakeroot \
  libarchive-devel openssl-devel gpgme-devel libtool gettext texinfo bison flex gmp-devel mpfr-devel libmpc-devel ncurses-devel diffutils \
  libusb-compat-0.1-devel readline-devel
