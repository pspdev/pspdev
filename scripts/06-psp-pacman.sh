#!/bin/bash
# psp-pacman.sh

# Exit on errors
set -e

# Download the source code.
clone_git_repo github.com pspdev psp-pacman ci

# Enter the source directory.
cd psp-pacman

# Build and install
./pacman.sh
