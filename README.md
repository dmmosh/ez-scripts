# EZ-SCRIPTS #

Pressing the same buttons/commands is not fun. Which is why I have made this collection of smaller scripts, made to automate the most basic of everyday tasks. Over time, these small increases to productivity will amount to great time savings.

My customn scripts for automating annoying tasks, compiled and wrapped in wrapping paper for you to enjoy yourself.

Every script comes with a ./install.sh script, handling all dependencies in the process.

I know it's not a lot right now.
I will introduce an installer, possibly using dialog, once this repo gets expanded with more convenient scripts.

All scripts can be reconfigured and recompiled.
The install script will recompile the script for you. So just change the .sh file, run `./install.sh`, and youre all set.

Just edit the .sh file and run the install script again. The install script will recompile the code and place it where it needs to be.

Supports Linux and MacOS (if you give the terminal full system access)



**generally the installation is:**
```
git clone https://github.com/dmmosh/ez-scripts
cd ./ez-scripts/<script name>
chmod +x ./install.sh
./install.sh
```

**with an uninstall option of:**
```
cd ./ez-scripts
cd <script folder name>
./uninstall.sh
```




# GIT-ALL #
A conveinent way to handle personal repos. A wrapper for running the most common git commands, with a few, expanded features. Designed for everyday use and easily scriptable into other programs.

**OPTIONS:**
```
   -h, --help			help page
   -s, --silence		silence the output
   -dm=, --def-msg=<text>	set default message
				will create a git-all-s.sh file in the script's directory
				('nothing of note' by default)

   -p=, --pull=<1/0, true/false> whether to do a git pull first
				will create a git-all-s.sh file in the script's directory
				(1 by default)

   <directory>			git commits in the passed directory
				by default will use the current dir / go down to parent dirs

   <message>			adds a custom message to the commit
				by default will be default message
```

**INSTALLATION:**
```
git clone https://github.com/wettestsock/ez-scripts
cd ./ez-scripts/git-all
chmod +x ./install.sh
./install.sh
```

**UNINSTALLATION:**
```
cd ./ez-scripts/git-all
./uninstall.sh
```

**DEPENDENCIES:**
- shc - the bash script compiler

note: dependency will be installed by the install script. the install script will compile the script and place it where it needs to be FOR YOU. i spent way too long coding this.
