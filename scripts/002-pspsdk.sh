#!/bin/bash
# pspsdk.sh by fjtrujy

## Download the source code.
REPO_URL="https://github.com/pspdev/pspsdk"
REPO_FOLDER="pspsdk"
BRANCH_NAME="master"
if test ! -d "$REPO_FOLDER"; then
	git clone --depth 1 -b $BRANCH_NAME $REPO_URL && cd $REPO_FOLDER || { exit 1; }
else
	cd $REPO_FOLDER && git fetch origin && git reset --hard origin/${BRANCH_NAME} || { exit 1; }
fi

## Build and install pspsdk
./build-and-install.sh || { exit 1; }
