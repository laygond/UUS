#!/bin/bash

# my reference:
# https://medium.com/devnetwork/how-to-create-your-own-custom-terminal-commands-c5008782a78e


# --------- CUSTOM COMMANDS by Bryan Laygond (personal) -----------

# Open Dropbox Paper Notes in Chrome
function paper() {
  google-chrome https://paper.dropbox.com/folder/show/Tutorials-e.1gg8YzoPEhbTkrhvQwJ2zzxOY3ofXnw0n4dMNrcQppzTfcD5Utlp
}

# Clone from GitHub faster
function clone() {
  if [[ $# -eq 1 ]]
  then
    git clone "https://github.com/laygond/$1.git"
  else
    echo "Just one argument allowed: insert repo name"
  fi
}

# Open a Python Playground
function pyground() {
  if [[ -e ~/playground.py ]]
  then
    code ~/playground.py
  else
    touch ~/playground.py
    code ~/playground.py
  fi
}

# Check CPU info
function cpuinfo() {
  cat /proc/cpuinfo
}

# Check Kernel info
function kernelinfo() {
  uname -a
}

# Check OS info
function osinfo() {
  cat /etc/os-release
}

# Check USB info
function usbinfo() {
  sudo cat /sys/kernel/debug/usb/devices
}

# Check CUDA info
function cudainfo() {
  cat /usr/local/cuda/version.txt
  nvcc --version
}

# Check cuDNN info
function cudnninfo() {
  echo "cuDNN $(cat /usr/local/cuda/include/cudnn.h | grep "#define CUDNN_MAJOR" -A 2 | grep -oE '[^[:space:]]+$'| paste -s -d ".")"
}

# Check GPU info
function gpuinfo() {
  nvidia-smi
}

# Check Volume info
function volumeinfo() {
  lsblk
  df -h
}

# Check Devices in Network
function fing() {
  GATEWAY=$(hostname -I | cut -d'.' -f-3) #-3 Since IPv4
  GATEWAY="$GATEWAY.0"
  nmap -sP $GATEWAY/24
}

# Format Mass Storage or Volume
function format() {
  if [[ $# -eq 1 ]]
  then
    sudo umount $1
    sudo mkfs.vfat $1
  else
    echo "Just one argument allowed: insert volume storage name"
  fi
}
