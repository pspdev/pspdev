#!/bin/bash
# psplinkusb by fjtrujy

## Download the source code.
REPO_URL="https://github.com/pspdev/psplinkusb"
REPO_FOLDER="psplinkusb"
BRANCH_NAME="master"
if test ! -d "$REPO_FOLDER"; then
	git clone --depth 1 -b $BRANCH_NAME $REPO_URL && cd $REPO_FOLDER || { exit 1; }
else
	cd $REPO_FOLDER && git fetch origin && git reset --hard origin/${BRANCH_NAME} || { exit 1; }
fi

## Determine the maximum number of processes that Make can work with.
PROC_NR=$(getconf _NPROCESSORS_ONLN)
OSVER=$(uname)

## Compile and install.
make --quiet -j $PROC_NR clean          			|| { exit 1; }
make --quiet -j $PROC_NR all            			|| { exit 1; }
# WIndows currently can't compile pspsh, usbhostfs_pc
if [ "${OSVER:0:5}" != MINGW ]; then
	make --quiet -j $PROC_NR -C pspsh install 			|| { exit 1; }
	make --quiet -j $PROC_NR -C usbhostfs_pc install 	|| { exit 1; }
fi

## Store build information
BUILD_FILE="${PSPDEV}/build.txt"
if [[ -f "${BUILD_FILE}" ]]; then
  sed -i'' '/^psplinkusb /d' "${BUILD_FILE}"
fi
git log -1 --format="psplinkusb %H %cs %s" >> "${BUILD_FILE}"
