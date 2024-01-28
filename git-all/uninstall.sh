#!/bin/bash

# UNINSTALLER 

echo -e "DELETING .DESKTOP FILE..."
if [ -d "/usr/share/applications" ]
then
   sudo rm /usr/share/applications/git-all.desktop
elif [ -d "~/.local/share/applications" ]
then
    sudo rm ~/.local/share/applications/git-all.desktop
fi

echo -e "DELETING CONFIG FOLDER..."
rm -rf /etc/git-all

echo -e "DELETING EXECUTABLE..."
rm /usr/bin/git-all.sh

