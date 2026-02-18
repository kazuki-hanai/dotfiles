#!/bin/bash

ISO_PATH="" 
USB_DISK=""
VOLUME_NAME="MBR"
MOUNT_POINT="/Volumes/WINISO"

# Read command line arguments
while getopts ":i:u:" opt; do
  case ${opt} in
    i ) ISO_PATH=$OPTARG ;;
    u ) USB_DISK=$OPTARG ;;
  esac
done

if [ -z "$ISO_PATH" ] || [ -z "$USB_DISK" ]; then
  echo "Usage: $0 -i <ISO_PATH> -u <USB_DISK>"
  echo "Example: $0 -i /path/to/Win10_22H2_English_x64.iso -u /dev/disk2"
  echo "Useful command to find USB disk: diskutil list"
  exit 1
fi

echo "[*] Unmounting USB..."
diskutil unmountDisk ${USB_DISK}

echo "[*] Erasing and formatting USB as FAT32..."
diskutil eraseDisk MS-DOS ${VOLUME_NAME} MBR ${USB_DISK}

echo "[*] Mounting ISO..."
hdiutil mount "$ISO_PATH"

ISO_MOUNT=$(mount | grep -i "$ISO_PATH" | awk '{print $3}')
if [ -z "$ISO_MOUNT" ]; then
  ISO_MOUNT=$(ls /Volumes | grep -i "CCCOMA" | head -n 1)
  ISO_MOUNT="/Volumes/$ISO_MOUNT"
fi

echo "[*] ISO mounted at $ISO_MOUNT"

echo "[*] Copying files to USB..."
cp -R "$ISO_MOUNT"/* /Volumes/${VOLUME_NAME}/

echo "[*] Unmounting all..."
hdiutil unmount "$ISO_MOUNT"
diskutil unmount /Volumes/${VOLUME_NAME}

echo "[✔] Done! Bootable USB is ready (hopefully)."