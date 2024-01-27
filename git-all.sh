#!/bin/bash

# GIT PULLS, GIT ADDS, COMMITS AND PUSHES
# convenient way of automating a repetive taskse

dir="."
dir_start=$(pwd)
git_msg=""

for i in "$@"
do 
	case "$i" in

	# if help message, prints help and quits
	"-h" | "--help")

	echo
	echo NAME:
	echo -e "\tGIT-ALL - lazy way to handle repos\n\thttps://github.com/wettestsock/ez-scripts/blob/main/git-all.sh\n\tby Dmytro Moshkovskyi"

	echo
	echo HOW IT WORKS:
	echo -e "\tpulls from repo\n\t -> adds all to staging area\n\t  -> commits with default/custom message\n\t   -> pushes to repo\n"

	echo
	echo USAGE:
	echo -e "   git-all [OPTIONS] ..."

	echo 
	echo OPTIONS:
	echo -e "   -h, --help\t\t\thelp page"
	echo -e "   <directory>\t\tgit commits in the passed directory"

	echo -e '   -dm=, --def-msg=<text>\tset default message'
	echo -e "\twill create a git-all-s.sh file in the script's directory\n\t('nothing of note' by default)"



	exit 1
	;;

	# if param is a directory
	-d)
		dir="$i"
		continue;
	;;

	# if param is a msg
	*)
		git_msg+="$i"
	;;

	esac
done

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
