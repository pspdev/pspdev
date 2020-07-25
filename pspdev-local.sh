#!/bin/bash
# pspdev-local.sh

export PSPDEV=$(pwd)/pspdev
export PATH=$PATH:$PSPDEV/bin

./pspdev.sh $@ || { echo "ERROR: Could not run the pspdev script."; exit 1; }
