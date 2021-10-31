#!/bin/bash
# psplibraries.sh

# Exit on errors
set -e

# Download the source code.
clone_git_repo github.com jopadan psplibraries

# Enter the source directory.
cd psplibraries

# Configure the build.
./libraries.sh
