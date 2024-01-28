#!/bin/bash

: '
    AN INIT FILE FOR GIT-ALL
    dsd
'

#installer
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"


#dir path of the executable
dir="$(realpath $(dirname $0))"


chmod +x "$dir/git-all.sh"
chmod +x "$dir/git-all.desktop"
chmod +x "$dir/uninstall.sh"

echo -e "COPYING THE .DESKTOP FILE..."
if [ -d "/usr/share/applications" ]
then
   sudo cp -r $dir/git-all.desktop /usr/share/applications
elif [ -d "~/.local/share/applications" ]
then
    sudo cp -r $dir/git-all.desktop ~/.local/share/applications
fi

echo -e "MAKING CONFIG FOLDER..."

if [ ! -d "~/.config/ez-scripts" ]
then 
mkdir ~/.config/ez-scripts
fi
mkdir ~/.config/ez-scripts/git-all

echo -e "MAKING CONFIG FILES..."


echo -e "MAKING EXECUTABLE..."
cp $dir/git-all /usr/bin
