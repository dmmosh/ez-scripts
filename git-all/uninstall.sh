#!/bin/bash

# UNINSTALLER 

# ask for sudo permissions
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"


echo -e "DELETING .DESKTOP FILE..." 
sudo rm /usr/share/applications/git-all.desktop

echo -e "DELETING CONFIG FOLDER..."
rm -rf ~/.config/ez-scripts/git-all

# if scripts folder is empty, remove it too
if [ -z "$(ls -a ~/.config/ez-scripts/)" ]
then
    rm -rf ~/.config/ez-scripts/
fi

echo -e "DELETING EXECUTABLE..." 
rm /usr/bin/git-all

echo -e "Thank you for using git-all. -Dmytro" 


