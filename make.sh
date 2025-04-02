#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "[*] This script must be run as root"
   exit 1
fi

if [[ -f "/sys/bus/wmi/devices/7A4DDFE7-5B5D-40B4-8595-4408E0CC7F56/" ]]; then
    echo "[*] Sorry but your device doesn't have the required WMI module"
    exit 1
fi

if [ ! "$(uname -r | grep lts)" == "" ]; then
    echo LTS kernel detected
    MAKEFLAGS="LTS=1"
fi

# compile the kernel module
if [ "$(cat /proc/version | grep clang)" != "" ]; then
    #For kernels compiled with clang
    make CC=clang LD=ld.lld $MAKEFLAGS
else
    #For normal kernels
    make $MAKEFLAGS
fi
