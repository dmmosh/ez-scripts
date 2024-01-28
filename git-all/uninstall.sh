#!/bin/bash

# UNINSTALLER 

# ask for sudo permissions
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

user_dir="$(eval echo ~$SUDO_USER)"


echo -e "DELETING .DESKTOP FILE..." 
sudo rm /usr/share/applications/git-all.desktop

echo -e "DELETING CONFIG FOLDER..."
rm -rf "$user_dir/.config/ez-scripts/git-all"

# if scripts folder is empty, remove it too
[ "$(ls -A "$user_dir/.config/ez-scripts/")" ] || rmdir "$user_dir/.config/ez-scripts/"


echo -e "DELETING EXECUTABLE..." 
rm "/usr/bin/git-all"

echo -e "Thank you for using git-all. -Dmytro" 


