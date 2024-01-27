#!/bin/bash

# GIT PULLS, GIT ADDS, COMMITS AND PUSHES
# convenient way of automating a repetive tasks

if [ "$1" == "--help" ] || [ "$1" == "-h" ]
then
	echo NAME
	echo -e "GIT-ALL - lazy way to handle repos\n by Dmytro Moshkovskyi\nhttps://github.com/wettestsock/ez-scripts/blob/main/git-all.sh"
	
	echo -e "pulls from repo -> adds everything -> commits with default/custom message -> pushes to repo\n"


fi


#newline
echo

git_msg="nothing of note"
dir="."
dir_start=$(pwd)

if [ -d "$1" ]	#if param 1 is directory 
then
	dir="$1"
	if [ "$2" ] #if param 2 is msg
	then
		git_msg="$2"
	fi
elif [ "$1" ] # elif param 1 is msg
then
	git_msg="$1"
fi	
#change to dir
cd $dir
if [ "$(git rev-parse --is-inside-work-tree)" != "true" ] # if theres no git repo
then
	cd $dir_start
	echo -e "NOT A REPO!!\n FIND A REPO!!\n"
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
