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

## gcc needs to include libcglue libpthreadglue libpsputility libpsprtc libpspnet_inet libpspnet_resolver libpspsdk libpspmodinfo libpspuser libpspkernel
## from pspsdk to be able to build executables, because they are part of the standard libraries
(cd "$PSPDEV/psp/sdk/lib/" && ln -sf libcglue.a ../../lib/) || { exit 1; }
(cd "$PSPDEV/psp/sdk/lib/" && ln -sf libpthreadglue.a ../../lib/) || { exit 1; }
(cd "$PSPDEV/psp/sdk/lib/" && ln -sf libpsputility.a ../../lib/) || { exit 1; }
(cd "$PSPDEV/psp/sdk/lib/" && ln -sf libpsprtc.a ../../lib/) || { exit 1; }
(cd "$PSPDEV/psp/sdk/lib/" && ln -sf libpspnet_inet.a ../../lib/) || { exit 1; }
(cd "$PSPDEV/psp/sdk/lib/" && ln -sf libpspnet_resolver.a ../../lib/) || { exit 1; }
(cd "$PSPDEV/psp/sdk/lib/" && ln -sf libpspsdk.a ../../lib/) || { exit 1; }
(cd "$PSPDEV/psp/sdk/lib/" && ln -sf libpspmodinfo.a ../../lib/) || { exit 1; }
(cd "$PSPDEV/psp/sdk/lib/" && ln -sf libpspuser.a ../../lib/) || { exit 1; }
(cd "$PSPDEV/psp/sdk/lib/" && ln -sf libpspkernel.a ../../lib/) || { exit 1; }
