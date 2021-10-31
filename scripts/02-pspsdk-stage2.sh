#!/bin/bash
# pspsdk-stage2.sh

# Exit on errors
set -e

# Download the source code if it does not already exist.
clone_git_repo github.com jopadan pspsdk

# Enter the source directory.
cd pspsdk

# Bootstrap the source.
./bootstrap

# Mac OS X fix
if [ "$(uname)" == "Darwin" ]; then
  export CFLAGS="$CFLAGS -I/opt/local/include"
  export CPPFLAGS="$CPPFLAGS -I/opt/local/include"
  export LDFLAGS="$LDFLAGS -L/opt/local/lib"
fi

# Configure the build.
./configure --with-pspdev="$PSPDEV"

# Build and install.
make clean
make
make install
