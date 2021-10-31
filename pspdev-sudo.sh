#!/bin/bash
# pspdev-sudo.sh
 
INSTALLDIR=/usr/local/pspdev
 
# Enter the pspdev directory
cd "`dirname $0`" || { echo "ERROR: Could not enter the pspdev directory."; exit $(false); }

# Set up the environment
export PSPDEV=$INSTALLDIR
export PATH=$PATH:$PSPDEV/bin

# Run the pspdev script
./pspdev.sh $@ || { echo "ERROR: Could not run the pspdev script."; exit $(false); }
