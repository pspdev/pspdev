#!/bin/bash

# Install build dependencies
sudo apt-get install $@ \
  git gzip libarchive-dev libcurl4 libcurl4-openssl-dev libelf-dev libgpgme-dev libncurses5-dev libreadline-dev libssl-dev \
  libtool-bin libusb-dev m4 make patch pkg-config python3 python3-venv subversion tar tcl texinfo unzip wget xz-utils \
  sudo fakeroot libarchive-tools curl libgmp3-dev libmpfr-dev libmpc-dev python3-pip
