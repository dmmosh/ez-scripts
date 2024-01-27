#!/bin/bash

# GIT PULLS, GIT ADDS, COMMITS AND PUSHES
# convenient way of automating a repetive taskse

dir="."
dir_start="$(pwd)"
git_msg=""

if [ -f "./git-all-s.sh" ]
then
	source "./git-all-s.sh"
fi

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


for i in "$@"
do 
	# HELP PAGE
	if [ "$i" == "-h" ] || [ "$i" == "--help" ]
	then
		help_page
	
	# if setting acustom default message
	#short 
	elif [ "${i:0:4}" == "-dm=" ] 
	then
		echo "${i:4:10}"
		exit 1
	# long
	elif [ "${i:0:10}" == "--def-msg=" ]
	then
		echo "${i:10:20}"
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

# if git message is blank (default)
if [ -z "$git_msg" ]
then
	$git_msg = "nothing of note"
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
