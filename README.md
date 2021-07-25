# pspdev
pspdev master repository

This is a repository for auto-builds of the whole psp toolchain using
GitHub actions.

## Building

### Prequisites:

#### Linux distributions

```console
$ ./depends/check-dependencies.sh

```

#### macOS:

```console
$ brew bundle
```

### Building the Toolchain

```console
export PSPDEV=/path/to/pspdev
export PATH=$PATH:$PSPDEV/bin
./pspdev.sh
```

There are specific scripts to aid building in some circumstances:
 - `pspdev-local.sh` 
 - `pspdev-sudo.sh` 
