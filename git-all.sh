#!/bin/bash

: "
snooping around the source code?
sure, go ahead

NAME:
   GIT-ALL - convenient way to handle personal repos
   https://github.com/wettestsock/ez-scripts/blob/main/git-all.sh
   by Dmytro Moshkovskyi

HOW IT WORKS:
   pulls from repo
    -> adds all to staging area
     -> commits with default/custom message
      -> pushes to repo

USAGE:
   git-all [OPTIONS] ...

OPTIONS:
   -h, --help			help page
   -dm=, --def-msg=<text>	set default message
				will create a git-all-s.sh file in the script's directory
				('nothing of note' by default)

   <directory>			git commits in the passed directory
				will use the current dir / go down to parent dirs

   <message>			adds a custom message to the commit

"


#calls a help page
help_page(){
echo
		echo NAME:
		echo -e "   GIT-ALL - convenient way to handle personal repos\n   https://github.com/wettestsock/ez-scripts/blob/main/git-all.sh\n   by Dmytro Moshkovskyi"

		echo
		echo HOW IT WORKS:
		echo -e "   pulls from repo\n    -> adds all to staging area\n     -> commits with default/custom message\n      -> pushes to repo"

		echo
		echo USAGE:
		echo -e "   git-all [OPTIONS] ..."

		echo 
		echo OPTIONS:
		echo -e "   -h, --help\t\t\thelp page"

		echo -e '   -dm=, --def-msg=<text>\tset default message'
		echo -e "\t\t\t\twill create a git-all-s.sh file in the script's directory\n\t\t\t\t('nothing of note' by default)\n"

		echo -e "   <directory>\t\t\tgit commits in the passed directory"
		echo -e "\t\t\t\twill use the current dir / go down to parent dirs\n"
		echo -e "   <message>\t\t\tadds a custom message to the commit"

		exit 1
}

#helper functions

#serialize
serialize() {
    typeset -p "$1" | sed -E '0,/^(typeset|declare)/{s/ / -g /}' > "./git-all-s.sh"
}

#deserialize
deserialize() {
    source "./git-all-s.sh"
}


dir="." #directory to be gitted into
dir_start="$(pwd)" #current dir
git_msg="" # the git message



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
			echo -e "\nFATAL ERROR:\n   No new default message provided.\n   Please provide a new default message."
			exit 1
		fi

		serialize git_msg

		exit 1
	# if relative dir (without ./) 
	elif [ -d "./$i" ] 
	then
		dir="./$i"
	
	# if relative (with ./) or absolute dir
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
	if [ -f "./git-all-s.sh" ]
	then
		deserialize git_msg

	#default (no serialization in place)
	else 
		git_msg="nothing of note"
	fi
fi

#change to the inputted (or default) dir
cd $dir

if [ "$(git rev-parse --is-inside-work-tree)" != "true" ] # if theres no git repo
then
	cd $dir_start
	echo -e "NOT A REPO!!\n FIND A REPO!!\n"
	help_page
	exit 1	
fi

git pull
git add --all && \
git commit -m "$git_msg" && \
git push && \
echo -e "REPO PUSHED" && \
echo -e "note: check the .gitignore file\n" && \
cd $dir_start && \
exit 1
# final exception handle
echo -e "SOMETHING DIDN'T WORK!!!!\nFAILED TO PUSH!!\n"	
cd $dir_start
