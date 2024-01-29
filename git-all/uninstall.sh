#!/bin/bash

# UNINSTALLER 

# ask for sudo permissions

# ROOT PERMISSIONS

if [ ! "$UID" -eq 0 ] 
then
    echo -e "FATAL ERROR:"
    echo -e "   Can't uninstall without root permissions."
    echo -e "   Please run 'sudo ./$(basename "$0")'."
    exit 1
fi



os="$(uname)"

home_dir="$HOME"

# for linux
if [ ! "$os" == "Darwin" ]
then
home_dir="/home/${SUDO_USER}"
fi




echo -e "DELETING CONFIG FOLDER..."
rm -rf "$home_dir/.config/ez-scripts/git-all"

# if scripts folder is empty, remove it too
[ "$(ls -A "$home_dir/.config/ez-scripts/")" ] || rmdir "$home_dir/.config/ez-scripts/"


echo -e "DELETING EXECUTABLE..." 
rm "/usr/bin/git-all"



if [ ! "$os" == "Darwin" ] 
then

echo -e "DELETING .DESKTOP FILE..." 
sudo rm /usr/share/applications/git-all.desktop

fi

echo -e "Thank you for using git-all. -Dmytro" 


