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




echo -e "DELETING CONFIG FOLDER..."
rm -rf "$HOME/.config/ez-scripts/git-all"

# if scripts folder is empty, remove it too
[ "$(ls -A "$HOME/.config/ez-scripts/")" ] || rmdir "$HOME/.config/ez-scripts/"


echo -e "DELETING EXECUTABLE..." 
rm "/usr/bin/git-all"



if [ ! "$os" == "Darwin" ] 
then

echo -e "DELETING .DESKTOP FILE..." 
sudo rm /usr/share/applications/git-all.desktop

fi

echo -e "Thank you for using git-all. -Dmytro" 


