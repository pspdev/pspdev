#!/bin/bash
# pspdev.sh

# Load and export shared functions
source common.sh
export -f auto_extract
export -f download_and_extract
export -f clone_git_repo

# Parallelize build
export MAKEFLAGS="-j`num_cpus`"

# Enter the pspdev directory.
cd "`dirname $0`" || { echo "ERROR: Could not enter the pspdev directory."; exit 1; }

# Create the build directory.
mkdir -p build || { echo "ERROR: Could not create the build directory."; exit 1; }

# Enter the build directory.
cd build || { echo "ERROR: Could not enter the build directory."; exit 1; }

# Fetch the depend scripts.
DEPEND_SCRIPTS=(`ls ../depends/*.sh | sort`)

# Run all the depend scripts.
for SCRIPT in ${DEPEND_SCRIPTS[@]}; do
  "$SCRIPT" || { echo "$SCRIPT: Failed."; exit 1; }
done

# Fetch the build scripts.
BUILD_SCRIPTS=(`ls ../scripts/*.sh | sort`)

# If specific steps were requested...
if [ $1 ]; then
  # Sort and run the requested build scripts.
  ARGS=(`printf "%.02d\n" $(trlz $@) | sort -n`)
  for ARG in ${ARGS[@]}; do
    found=0
    for SCRIPT in ${BUILD_SCRIPTS[@]}; do
      if [ `basename $SCRIPT | cut -c -2` -eq $ARG ]; then
        found=1
        "$SCRIPT" || { echo "$SCRIPT: Failed."; exit 1; }
      fi
    done
    [ $found -eq 1 ] || { echo "$ARG: Script not found."; exit 1; }
  done
else
  # Run all the existing build scripts.
  for SCRIPT in ${BUILD_SCRIPTS[@]}; do
    "$SCRIPT" || { echo "$SCRIPT: Failed."; exit 1; }
  done
fi
