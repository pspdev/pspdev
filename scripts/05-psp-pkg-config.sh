#!/bin/bash
# psp-pkg-config.sh

# Exit on errors
set -e

# Download the source code.
clone_git_repo github.com pspdev psp-pkgconf

# Enter the source directory.
cd psp-pkgconf

# Build and install.
make clean
make
make install
