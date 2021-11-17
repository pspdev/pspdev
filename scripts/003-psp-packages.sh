#!/bin/bash
# psp-packages by fjtrujy

## Download the source code.
REPO_URL="https://github.com/pspdev/psp-packages"
REPO_FOLDER="psp-packages"
BRANCH_NAME="master"
if test ! -d "$REPO_FOLDER"; then
	git clone --depth 1 -b $BRANCH_NAME $REPO_URL && cd $REPO_FOLDER || { exit 1; }
else
	cd $REPO_FOLDER && git fetch origin && git reset --hard origin/${BRANCH_NAME} || { exit 1; }
fi


# WIndows currently doesn't have pacman, so packages needs to be installed manually
OSVER=$(uname)
install_method="pacman"
if [ "${OSVER:0:5}" == MINGW ]; then
	install_method="manually"
fi

# Install all packages
./install-latest.sh  "pspdev/psp-packages"  $install_method || { exit 1; }