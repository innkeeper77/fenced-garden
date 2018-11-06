#!/bin/bash
# Garden Control: Bash script for menu driven control over restricted accounts
# Main Menu
# ----------------------------------

# Variables: 

EDITOR=nano
PASSWD=/etc/passwd
RED='\033[0;41;30m'
STD='\033[0;0;39m'
 
# Functions: 

pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}

one(){
	echo "Calling lock script . . ."
	(. ./locking.sh)
}
 
two(){
    echo "Calling application restriction settings script . . ."
	(. ./groups.sh)
}

three(){
	echo "Calling password changing script . . ."
	(. ./passwordchanger.sh) 
}

four(){
	echo "Calling adding/removing users script . . ."
	(. ./users.sh) 
}
 
show_menus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~"	
	echo " GARDEN CONTROL PANEL "
	echo "~~~~~~~~~~~~~~~~~~~~~~"
	echo "1. Lock/Unlock Accounts"
	echo "2. Restrict Application groups"
	echo "3. Change Passwords"
	echo "4. Create/Delete Restricted Accounts"
	echo "5. Exit"
}

read_options(){
	local choice
	read -p "Enter choice [ 1 - 5] " choice
	case $choice in
		1) one ;;
		2) two ;;
		3) three ;;
		4) four ;;
		5) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}


# Trap CTRL+C, CTRL+Z and quit singles
# trap '' SIGINT SIGQUIT SIGTSTP
 
# Main logic - infinite loop
while true
do
	show_menus
	read_options
done



# Credits
# Used menu template from https://bash.cyberciti.biz/guide/Menu_driven_scripts
# Created by innkeeper77 2017
# MIT license. No warranty! See license file
