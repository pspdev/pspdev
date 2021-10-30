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
cd "`dirname $0`" || { echo "ERROR: Could not enter the pspdev directory."; exit $(false); }

# Create the build directory.
mkdir -p build || { echo "ERROR: Could not create the build directory."; exit $(false); }

# Enter the build directory.
cd build || { echo "ERROR: Could not enter the build directory."; exit $(false); }

# Fetch the depend scripts.
DEPEND_SCRIPTS=(`ls ../depends/*.sh | sort`)

# Run all the depend scripts.
for SCRIPT in ${DEPEND_SCRIPTS[@]}; do
  "$SCRIPT" || { echo "$SCRIPT: Failed."; exit $(false); }
done

# Fetch the build scripts.
BUILD_SCRIPTS=(`ls ../scripts/*.sh | sort`)

# If specific steps were requested...
if [ $1 ]; then
  # Sort and run the requested build scripts.
  ARGS=(`printf "%.02d\n" $(trlz $@) | sort -n`)
  for ARG in ${ARGS[@]}; do
    found=$(false)
    for SCRIPT in ${BUILD_SCRIPTS[@]}; do
      if [ `basename $SCRIPT | cut -c -2` -eq $ARG ]; then
        found=$(true)
        "$SCRIPT" || { echo "$SCRIPT: Failed."; exit $(false); }
      fi
    done
    [ $found -eq $(true) ] || { echo "$ARG: Script not found."; exit $(false); }
  done
else
  # Run all the existing build scripts.
  for SCRIPT in ${BUILD_SCRIPTS[@]}; do
    "$SCRIPT" || { echo "$SCRIPT: Failed."; exit $(false); }
  done
fi
