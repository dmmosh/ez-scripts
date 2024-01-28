
: '
    AN INIT FILE FOR GIT-ALL
'

#dir path of the executable
dir="$(realpath $(dirname $0))"


chmod +x "$dir/git-all.sh"
chmod +x "$dir/git-all.desktop"

echo -e "COPYING THE .DESKTOP FILE..."
if [ -d "/usr/share/applications" ]
then
   sudo cp -r $dir/git-all.desktop /usr/share/applications
elif [ -d "~/.local/share/applications" ]
then
    sudo cp -r $dir/git-all.desktop ~/.local/share/applications
fi

echo -e "MAKING CONFIG FOLDER..."
mkdir /etc/git-all/

cp $dir/git-all.sh /usr/bin
