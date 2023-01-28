# PSPDEV

[![CI](https://img.shields.io/github/actions/workflow/status/pspdev/pspdev/.github/workflows/compilation.yml?branch=master&style=for-the-badge&logo=github&label=CI)](https://github.com/pspdev/pspdev/actions?query=workflow:CI) [![CI-Docker](https://img.shields.io/github/actions/workflow/status/pspdev/pspdev/.github/workflows/docker.yml?branch=master&style=for-the-badge&logo=github&label=CI-Docker)](https://github.com/pspdev/pspdev/actions?query=workflow:CI-Docker) [![Docker Pulls](https://img.shields.io/docker/pulls/pspdev/pspdev?style=for-the-badge)](https://hub.docker.com/r/pspdev/pspdev/tags)

Main PSP Repo for building the whole `PSP Development` environment in your local machine.

## Table of Contents

- [PSPDEV](#pspdev)
  - [Table of Contents](#table-of-contents)
  - [Up and running](#up-and-running)
  - [What these scripts do](#what-these-scripts-do)
  - [Requirements](#requirements)
    - [Ubuntu/Debian](#ubuntudebian)
    - [Fedora](#fedora)
    - [Arch](#arch)
    - [OSX](#osx)
  - [Docker generation](#docker-generation)
  - [Extra steps](#extra-steps)
    - [macOS](#macos)
    - [Local package builds](#local-package-builds)
  - [Thanks](#thanks)

This program will automatically build and install the whole compiler and other tools used in the creation of Homebrew software for the Sony PlayStation Portable® video game system.

## Up and running

You can get started very quickly by grabbing the latest development pre-releases from the [releases' page for your platform](https://github.com/pspdev/pspdev/releases) and extract them to the `pspdev` directory in your `path`.

Export the `PSPDEV` environment variable to point to the `pspdev` directory. For example:

  ```bash
  export PSPDEV=~/pspdev
  export PATH=$PATH:$PSPDEV/bin
  ```

## What these scripts do

These scripts download (`git clone`) and install:

- [psptoolchain](https://github.com/pspdev/psptoolchain "psptoolchain")
- [pspsdk](https://github.com/pspdev/pspsdk "pspsdk")
- [psp-packages](https://github.com/pspdev/psp-packages "psp-packages")
- [psplinkusb](https://github.com/pspdev/psplinkusb "psplinkusb")
- [ebootsigner](https://github.com/pspdev/ebootsigner "ebootsigner")

## Requirements

- Install
 `gcc/clang`, `make`, `cmake`, `patch`, `git`, `texinfo`, `flex`, `bison`, `gettext`, `wget`, `gsl`, `gmp`, `mpfr`, `mpc`, `libusb`, `readline`, `libarchive`, `gpgme`, `bash`, `openssl` and `libtool`.
- If you don't have those.
We offer a script to help you for installing dependencies:

### Ubuntu/Debian

```bash
sudo ./prepare-debian-ubuntu.sh
```

### Fedora

```bash
sudo ./prepare-fedora.sh
```

### Arch

```bash
sudo ./prepare-arch.sh
```

### OSX

```bash
sudo ./prepare-mac-os.sh
```

1. _Optional._ If you are upgrading from the previous version of the PSPDEV environment, it is highly recommended removing the content of the PSPDEV folder before upgrade. This is a necessary step after the major toolchain upgrade.

    ```bash
    sudo rm -rf $PSPDEV
    ```

2. Ensure that you have enough permissions for managing PSPDEV location (default to `/usr/local/pspdev`, but you can use a different path). PSPDEV location MUST NOT have spaces or special characters in its path! PSPDEV should be an absolute path. On Unix systems, if the command `mkdir -p $PSPDEV` fails for you, you can set access for the current user by running commands:

    ```bash
    export PSPDEV=/usr/local/pspdev
    sudo mkdir -p $PSPDEV
    sudo chown -R $USER: $PSPDEV
    ```

3. Add this to your login script (example: `~/.bash_profile`)
    **Note:** Ensure that you have full access to the PSPDEV path. You can change the PSPDEV path with the following requirements: only use absolute paths, don't use spaces, only use Latin characters.

    ```bash
    export PSPDEV=/usr/local/pspdev
    export PATH=$PATH:$PSPDEV/bin
    ```

4. Run build-all.sh

    ```bash
    ./build-all.sh
    ```

## Docker generation

This repo also uses CI/CD to create a docker image called `pspdev/pspdev:latest` per change. This is useful if you're a developer that wants to create/port an application to the PSP. You can compile your project using this docker image.

## Extra steps

If you want, you can _JUST_ install the extra dependencies as `psplinkusb and ebootsigner`. To achieve this execute

```**bash**
./build-extra.sh
```

### macOS

If you download the pre-built macOS binaries and get a security error such as _`"pspsh" cannot be opened because the developer cannot be verified.`_, you can remove the quarantine attribute by running:

```bash
xattr -dr com.apple.quarantine path/to/prebuilt/pspdev
```

### Local package builds

The toolchain (binutils, gcc), the SDK (pspsdk) and the host tools are built locally. However, the provided packages (psp-packages) are installed via `psp-pacman` (or a similar mechanism if not available), which fetches packages from [GitHub releases](https://github.com/pspdev/psp-packages/releases). If you wish to build these packages locally, you might define the variable _LOCAL_PACKAGE_BUILD_ which will force pacman to build the packages from source instead of downloading them:

```bash
LOCAL_PACKAGE_BUILD=1 ./build-all.sh
```

This is particularly useful if you are testing changes in the toolchain (i.e. gcc or binutils) and want to test your changes end to end. It can also be useful if you want a hermetic build and don't want to use any of the provided binaries.

## Thanks
