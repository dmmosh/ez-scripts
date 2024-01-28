#!/bin/bash

: '
    AN INIT FILE FOR GIT-ALL
    dsd
'

# ROOT PERMISSIONS
if [ ! "$UID" -eq 0 ]
then
    echo -e "FATAL ERROR:"
    echo -e "   NEED ROOT PRIVILEDGES TO RUN THE INSTALL SCRIPT"
    echo -e "   RUN 'sudo ./$(basename "$0")'"
    exit 1
fi


# GET DEPENDENCIES (linux and macos)

# Determine OS name

os="$(uname)" # default for macos

#finds linux distro
if [ -f /etc/os-release ]
then
    source "/etc/os-release"
    os=$ID

# checks if it's android
elif [ ! -z "$(echo $TERMUX_VERSION)" ]
then
    os="android"
fi

# Desktop manager
pkg_manager=""
os="dfsfiou"

# IF LINUX - FIND THE DISTRO
#TODO: dont forget to add sudo
case "$os" in
    # ARCH
    arch)
    echo hi
    pkg_manager="yay -S"        
    ;;

    # MANJARO
    manjaro)
    pkg_manager="sudo pacman -Sy"
    ;;

    # UBUNTU AND DLINUX MINT
    ubuntu | linuxmint)
    pkg_manager="sudo apt install"
    ;;

    # FEDORA
    fedora)
    pkg_manager="sudo dnf install"
    ;;

    # RASBERRY PI
    raspbian)
    pkg_manager="sudo apt-get install"
    ;;

    # CENT OS
    centos)
    pkg_manager="yum -y install"
    ;;

    # MACOS
    Darwin)
    # if brew isn't installed, install it
    if [ -z "$(brew --help | grep 'Example usage:')" ] 
    then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    pkg_manager="brew install"
    ;;

    # android
    android)
    pkg_manager="pkg install"
    ;;
    
esac
exit 1


#dir path of the executable
#dir="$(realpath $(dirname $0))"
dir="$(pwd)"

# have to do sudo user for linux whereas macos keeps it at home variable
user_dir= [ "$os" = "Darwin" ] && "$(echo $HOME)" || "$(eval echo ~$SUDO_USER)"

# if os is supported, install the dependencies
if [ ! -z "$os" ] 
then
    bash -c "$pkg_manager shc && $pkg_manager gcc"
fi

# checking if dependencies are installed 
if [ -z "$(gcc --help) | grep 'Usage:')" ]
then
    echo -e "FATAL ERROR:"
    echo -e "   GCC not found.\n   Please install gcc and run 'sudo ./$(basename "$0")' again."
    exit 1
elif [ -z "$(shc -help | grep 'shc Version')" ]
then
    echo -e "FATAL ERROR:"
    echo -e "   SHC not found.\n   Please install shc and run 'sudo ./$(basename "$0")' again."
    exit 1
fi

if [ "$os" == "Darwin" ]
then

fi




chmod +x "$dir/git-all.sh"
chmod +x "$dir/git-all.desktop"
chmod +x "$dir/uninstall.sh"

echo -e "COMPILING THE EXECUTABLE..."
shc -f ./git-all.sh -o /usr/bin/git-all


echo -e "COPYING THE .DESKTOP FILE..."
if [ -d "/usr/share/applications" ]
then
   sudo cp -r $dir/git-all.desktop /usr/share/applications
elif [ -d ".local/share/applications" ]
then
    sudo cp -r $dir/git-all.desktop "$user_dir.local/share/applications"
fi

echo -e "MAKING CONFIG FOLDER..."

mkdir -p "$user_dir/.config/ez-scripts"
mkdir -p "$user_dir/.config/ez-scripts/git-all"

touch "$user_dir/.config/ez-scripts/git-all/git-all-sm.sh"
chmod +x "$user_dir/.config/ez-scripts/git-all/git-all-sm.sh"

touch "$user_dir/.config/ez-scripts/git-all/git-all-sp.sh"
chmod +x "$user_dir/.config/ez-scripts/git-all/git-all-sp.sh"




echo -e "MAKING EXECUTABLE..."
cp $dir/git-all /usr/bin 
