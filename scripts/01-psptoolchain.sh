#!/bin/bash
# psptoolchain.sh

# Exit on errors
set -e

# Download the source code.
clone_git_repo github.com jopadan psptoolchain

# Enter the source directory.
cd psptoolchain

# Configure the build.
./toolchain.sh
