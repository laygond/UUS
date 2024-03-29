#!/bin/bash

# my reference:
# https://medium.com/devnetwork/how-to-create-your-own-custom-terminal-commands-c5008782a78e


# --------- CUSTOM COMMANDS by Bryan Laygond (personal) -----------

# Speed Alias
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

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
    echo "[ERROR] Just one argument allowed: insert repo name"
  fi
}

# Push to GitHub faster
function push() {
  if [[ $# -eq 1 ]]
  then
    git add .
    git commit -m "$1"
    git push
  else
    echo "[ERROR] Just one argument allowed: insert commit comment"
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

# Open My Custom Unix Commands (this file)
function mycmd() {
  code $(dirname ${BASH_SOURCE[0]})
}

# Check CPU info
function cpuinfo() {
  echo "[INFO] Command: cat /proc/cpuinfo"
  cat /proc/cpuinfo
  echo "[INFO] Command: sensors"
  sensors
}

# Check Kernel info
function kernelinfo() {
  echo "[INFO] Command: uname -a"
  uname -a
}

# Check OS info
function osinfo() {
  echo "[INFO] Command: cat /etc/os-release"
  cat /etc/os-release
}

# Check USB info
# from https://unix.stackexchange.com/questions/144029/command-to-determine-ports-of-a-device-like-dev-ttyusb0
function usbinfo() {
  sudo cat /sys/kernel/debug/usb/devices

  echo -e "\n Paths"
  for sysdevpath in $(find /sys/bus/usb/devices/usb*/ -name dev); do
  (
    syspath="${sysdevpath%/dev}"
    devname="$(udevadm info -q name -p $syspath)"
    [[ "$devname" == "bus/"* ]] && exit
    eval "$(udevadm info -q property --export -p $syspath)"
    [[ -z "$ID_SERIAL" ]] && exit
    echo "/dev/$devname - $ID_SERIAL"
  )
  done
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
  echo "[INFO] Command: nvidia-smi"
  nvidia-smi
  echo "[INFO] For more information try "
  echo "[INFO] Command: nvidia-settings"
}

# Check Volume info
function volumeinfo() {
  echo "[INFO] Command: lsblk"
  lsblk
  echo "[INFO] Command: df -h"
  df -h
  echo "[INFO] Command: sudo lvmdiskscan"
  sudo lvmdiskscan
  echo "[INFO] To see used space at current directory try: du -sh"
}

# Check Network Ports info
function portinfo() {
  echo "[INFO] Command: sudo netstat -tulpn"
  sudo netstat -tulpn
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

# Create train, val, test directory structure
function mk3dir() {
  if [[ $# -eq 1 ]]
  then
    mkdir -p $1/train
    mkdir -p $1/val
    mkdir -p $1/test
  else
    echo "Just one argument allowed: insert folder name"
  fi
}

# Apply command to all elements in list non-stopping
# map COMMAND: ITEM1 ITEM2 ITEM3 ...
# "map pip install: $(cat requirements.txt)"
# The space following the colon is required. Space preceding is optional.
function map (){
    local command i rep
    if [ $# -lt 2 ] || [[ ! "$@" =~ :[[:space:]] ]];then
        echo "Invalid syntax." >&2; return 1
    fi
    until [[ $1 =~ : ]]; do
        command="$command $1"; shift
    done
    command="$command ${1%:}"; shift
    for i in "$@"; do
        if [[ $command =~ \{\} ]];then
            rep="${command//\{\}/\"$i\"}"
            eval "${rep//\\/\\\\}"
        else
            eval "${command//\\/\\\\} \"${i//\\/\\\\}\""
        fi
    done
}