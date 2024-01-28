#!/bin/bash

# UNINSTALLER 

# ask for sudo permissions
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"


echo -e "DELETING .DESKTOP FILE..." 
sudo rm /usr/share/applications/git-all.desktop

echo -e "DELETING CONFIG FOLDER..."
rm -rf /etc/git-all 

echo -e "DELETING EXECUTABLE..." 
rm /usr/bin/git-all

echo -e "Thank you for using git-all. -Dmytro" 


