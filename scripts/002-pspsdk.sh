#!/bin/bash
# pspsdk.sh by fjtrujy

## Download the source code.
REPO_URL="https://github.com/fjtrujy/pspsdk"
REPO_FOLDER="pspsdk"
BRANCH_NAME="master"
if test ! -d "$REPO_FOLDER"; then
	git clone --depth 1 -b $BRANCH_NAME $REPO_URL && cd $REPO_FOLDER || { exit 1; }
else
	cd $REPO_FOLDER && git fetch origin && git reset --hard origin/${BRANCH_NAME} || { exit 1; }
fi

## Determine the maximum number of processes that Make can work with.
PROC_NR=$(getconf _NPROCESSORS_ONLN)

## Boostrap and config
./bootstrap || { exit 1; }
./configure --quiet || { exit 1; }

## Compile and install.
make --quiet -j $PROC_NR clean          || { exit 1; }
make --quiet -j $PROC_NR all            || { exit 1; }
make --quiet -j $PROC_NR install        || { exit 1; }
make --quiet -j $PROC_NR clean          || { exit 1; }

## gcc needs to include libcglue libpsputility libpsprtc libpspnet_inet libpspnet_resolver libpspuser libpspkernel
## from pspsdk to be able to build executables, because they are part of the standard libraries
ln -sf "$PSPDEV/psp/sdk/lib/libcglue.a" "$PSPDEV/psp/lib/libcglue.a" || { exit 1; }
ln -sf "$PSPDEV/psp/sdk/lib/libpsputility.a" "$PSPDEV/psp/lib/libpsputility.a" || { exit 1; }
ln -sf "$PSPDEV/psp/sdk/lib/libpsprtc.a" "$PSPDEV/psp/lib/libpsprtc.a" || { exit 1; }
ln -sf "$PSPDEV/psp/sdk/lib/libpspnet_inet.a" "$PSPDEV/psp/lib/libpspnet_inet.a" || { exit 1; }
ln -sf "$PSPDEV/psp/sdk/lib/libpspnet_resolver.a" "$PSPDEV/psp/lib/libpspnet_resolver.a" || { exit 1; }
ln -sf "$PSPDEV/psp/sdk/lib/libpspuser.a" "$PSPDEV/psp/lib/libpspuser.a" || { exit 1; }
ln -sf "$PSPDEV/psp/sdk/lib/libpspkernel.a" "$PSPDEV/psp/lib/libpspkernel.a" || { exit 1; }