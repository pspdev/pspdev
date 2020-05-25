#!/bin/bash
# ebootsigner.sh

# Exit on errors
set -e

# Download the source code if it does not already exist.
clone_git_repo github.com int-0 ebootsigner

# Enter the source directory.
cd ebootsigner
 
# Build and install
make clean
make
make install
