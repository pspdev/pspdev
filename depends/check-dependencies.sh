#!/bin/bash

function check_library
{
    pkg-config --exists "$1"
    if [ $? -eq 0 ]; then
        return 0
    else
        missing_depends+=($1); return 1
    fi
}

function check_program
{
    which "$1" >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        return 0
    else
        missing_depends+=($1); return 1
    fi
}

check_program   git
check_program   patch
check_program   autoconf
check_program   automake
check_program   make
check_program   cmake
check_program   gcc
check_program   g++
check_program   bison
check_program   flex
check_program   python3
check_program   pip3
check_program   gpgme-tool

# macOS uses it's own fork of libtool
if [ "$(uname)" != "Darwin" ]; then
check_program libtoolize
else
check_program glibtoolize
fi 

check_library   libarchive
check_library   openssl         
check_library   ncurses

if [ ${#missing_depends[@]} -ne 0 ]; then
    echo "Couldn't find dependencies:"
    for dep in "${missing_depends[@]}"; do
        echo "  - $dep"
    done
	exit 1
fi