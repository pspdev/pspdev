#!/bin/bash

# Install build dependencies
sudo apt-get install $@ \
  @development-tools gcc gcc-c++ g++ wget git autoconf automake python3 python3-pip make cmake pkgconf \
  libarchive-devel openssl-devel gpgme-devel libtool gettext texinfo bison flex gmp-devel mpfr-devel libmpc-devel ncurses-devel diffutils \
  libusb-devel