#!/bin/bash
# psptoolchain.sh by fjtrujy

## Download the source code.
REPO_URL="https://github.com/fjtrujy/psptoolchain"
REPO_FOLDER="psptoolchain"
BRANCH_NAME="master"
if test ! -d "$REPO_FOLDER"; then
	git clone --depth 1 -b $BRANCH_NAME $REPO_URL && cd $REPO_FOLDER || { exit 1; }
else
	cd $REPO_FOLDER && git fetch origin && git reset --hard origin/${BRANCH_NAME} || { exit 1; }
fi

## Build and install.
./toolchain.sh || { exit 1; }
