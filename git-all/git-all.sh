#!/bin/bash

: "
snooping around the source code?
sure, go ahead
"



dir="." #directory to be gitted into
dir_start="$(pwd)" #current dir
git_msg="" # the git message
git_silence=false # whether to silence or notfd
git_pull="true" # default true
home_dir="$HOME" # home dir, normal unless running root

#calls a help page
help_page(){
echo
		echo NAME:
		echo -e "   GIT-ALL\n   convenient way to handle personal repos\n   https://github.com/wettestsock/ez-scripts/blob/main/git-all.sh\n   by Dmytro Moshkovskyi"

		echo
		echo HOW IT WORKS:
		echo -e "   pulls from repo (by default)\n    -> adds all to staging area\n     -> commits with default/custom message\n      -> pushes to repo"

		echo
		echo USAGE:
		echo -e "   git-all [OPTIONS] ..."

		echo 
		echo OPTIONS:
		echo -e "   -h, --help\t\t\thelp page"

		echo -e '   -s, --silence\t\tsilence the output'

		echo -e '   -dm=, --def-msg=<text>\tset default message'
		echo -e "\t\t\t\twill create a git-all-s.sh file in the script's directory\n\t\t\t\t('nothing of note' by default)\n"

		echo -e '   -p=, --pull=<1/0, true/false> whether to do a git pull first'
		echo -e "\t\t\t\twill create a git-all-s.sh file in the script's directory\n\t\t\t\t(1 by default)\n"

		echo -e "   <directory>\t\t\tgit commits in the passed directory"
		echo -e "\t\t\t\tby default will use the current dir / go down to parent dirs\n"

		echo -e "   <message>\t\t\tadds a custom message to the commit"
		echo -e "\t\t\t\tby default will be default message"

		exit 1
}

info(){
   	echo -e "   Type 'git-all --help' for more info."
}
#serialize
serialize() {
	# the file to serialize to

	# default dm 
	file="git-all-sm.sh"

	# if pull status
	if [ "$1" == "git_pull" ]
	then
		file="git-all-sp.sh"
	fi

    #typeset -p "$1" | sed -E '0,/^(typeset|declare)/{s/ / -g /}f' > "$home_dir/.config/ez-scripts/git-all/$file"
    "$(echo "$(typeset -p "$1" | sed -E '0,/^(typeset|declare)/{s/ / -g /}')" | sudo tee $config_dir/$file)"
}

#deserialize
deserialize() {
	# the file to serialize to
	file="git-all-sm.sh"

	if [ "$1" == "git_pull" ]
	then
		file="git-all-sp.sh"
	fi

    source "$config_dir/$file"
}



# if running as sudo
if [ "$UID" -eq 0 ]
then
	home_dir="$(eval echo ~$SUDO_USER)"
fi

config_dir="$home_dir/.config/ez-scripts/git-all"

# iterates through parameters
for i in "$@"
do 
	# HELP PAGE
	if [ "$i" == "-h" ] || [ "$i" == "--help" ]
	then
		help_page
	
	# if setting custom default message
	elif [ "$(echo $i | cut -d'=' -f1)" == "-dm" ] || [ "$(echo $i | cut -d'=' -f1)" == "--def-msg" ]
	then
		# the new message
		git_msg="$(echo $i | cut -d'=' -f2)"

		# if the message is blank
		if [ -z "$git_msg" ]
		then
			echo -e "\nFATAL ERROR:\n   No new default message provided."
			info
			exit 1
		fi

		serialize git_msg

		# if no config file
		if [ ! -f "$config_dir/git-all-sm.sh" ]
		then
			echo -e "\nFATAL ERROR:\n   Something went HORRIBLY wrong.\n   Serialization failed."
			info
			exit 1
		fi

		# print message
		if [ "$git_silence" == "false" ]
		then
		echo -e "\nDEFAULT MESSAGE $(echo "$git_msg" | tr a-z A-Z) SERIALIZED IN:"
		echo "$config_dir/git-all-sm.sh"
		fi

		exit 1
	
	# if setting whether to pull or not
	elif [ "$(echo $i | cut -d'=' -f1)" == "-p" ] || [ "$(echo $i | cut -d'=' -f1)" == "--pull" ] 
	then
		git_pull="$(echo $i | cut -d'=' -f2)"

		# if pull is false
		if [ "$(echo "$git_pull" | tr A-Z a-z)" == "false" ] || [ "$git_pull" == "0" ]
		then
			git_pull="false"
		
		# if pull is true
		elif [ "$(echo "$git_pull" | tr A-Z a-z)" == "true" ] || [ "$git_pull" == "1" ]
		then
			git_pull="true"

		# if no arg is given
		elif [ -z "$git_pull" ]
		then
			echo -e "\nFATAL ERROR:\n   No pull status provided.\n   Please provide a pull status."
			info
			exit 1
		
		# if some other typo
		else
			echo -e "\nFATAL ERROR:\n   That's not a valid pull status.\n   Please provide a pull status."
			info
			exit 1
		fi 

		serialize git_pull

		# something bad happene
		if [ ! -f "$config_dir/git-all-sp.sh" ]
		then
			echo -e "\nFATAL ERROR:\n   Something went HORRIBLY wrong.\n   Serialization failed."
			info
			exit 1
		fi

		if [ "$git_silence" == "false" ]
		then
		echo -e "\nPULL STATUS of $(echo "$git_pull" | tr a-z A-Z) SERIALIZED IN:"
		echo "$config_dir/git-all-sp.sh"
		fi
		exit 1

	#silence the output
	elif [ "$i" == "-s" ] || [ "$i" == "--silence" ]
	then
		git_silence="true"
		
	# if relative dir (without ./) 
	elif [ -d "./$i" ] 
	then
		dir="./$i"
	
	# if relative (with ./) or absolute dirfd
	elif [ -d "$i" ]
	then
		dir="$i"
	# if git message
	else
		git_msg+="$i "
	fi
done


# if git message is blank (default msg)
if [ -z "$git_msg" ]
then
	# if no custom message and git message is blank
	if [ -f "$config_dir/git-all-sm.sh" ]
	then
		deserialize git_msg

	#default (no serialization in place)
	else 
		git_msg="nothing of note"
	fi
fi


# pull status
if [ -f "$config_dir/git-all-sp.sh" ]
then
	deserialize git_pull
fi


#change to the inputted (or default) dir
cd $dir


if [ "$(git rev-parse --is-inside-work-tree)" != "true" ] # if theres no git repo
then
	cd $dir_start
	echo -e "FATAL ERROR:\n   Not a repo!!\n   Find a repo!!"
	info
	exit 1	
fi

# check if branch is up to date with origin
# ugly way to do it but it works
if [ "$(git status -uno | grep 'nothing to commit (use -u to show untracked files)')" == "nothing to commit (use -u to show untracked files)" ] && [ -z "$(git status -uno | grep 'Your branch is ahead of')" ]
then
	[ "$git_silence" == "true" ] || git status -uno
	exit 1
fi

# ugly piece of code
# TODO: fix this monstrocity
[ "$git_pull" == "true" ] && ( [ "$git_silence" == "true" ] && git pull &> /dev/null || git pull ) && \
[ "$git_silence" == "true" ] && git add . &> /dev/null || git add . && \
[ "$git_silence" == "true" ] && git commit -m "$git_msg" &> /dev/null || git commit -m "$git_msg" && \
[ "$git_silence" == "true" ] && git push &> /dev/null || git push && \
[ "$git_silence" == "true" ] || echo -e "REPO PUSHED VERY SUCCESSFULLY" && \
cd $dir_start && \
exit 1
# final exception handle
echo -e "FATAL ERROR:\n   SOMETHING DIDN'T WORK!!!"
info	
cd $dir_start
