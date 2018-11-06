#!/bin/bash
# Garden Control: Bash script for menu driven control over restricted accounts
# passwordchanger.sh - subscript for changing passwords. Shocking..
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

show_menus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~"	
	echo "   CHANGE PASSWORDS   "
	echo "~~~~~~~~~~~~~~~~~~~~~~"
	echo "1. This Account"
	echo "2. Restricted Accounts"
	echo "3. Exit"
}

read_options(){
	local choice
	read -p "Enter choice [ 1 - 3] " choice
	case $choice in
		1) one ;;
		2) chooser ;;
		3) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

one(){
	clear
	echo "Changing password for your own account"
	sudo passwd $account
	clear
	echo "Password changed for your own account"
	pause
	exit 0
}

chooser(){
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~"	
	echo "     CHOOSE USER      "
	echo "~~~~~~~~~~~~~~~~~~~~~~"
	echo "Which restricted account password do you wish to change?"
	PS3="Please select username:"
		select account in $(< restrictedusers)
		do
				clear
				echo "Changing password for $account"
				sudo passwd $account
				clear
				echo "Password changed for $account"
				pause
				exit 0
		done
}
 
# Trap CTRL+C, CTRL+Z and quit singles
# trap '' SIGINT SIGQUIT SIGTSTP
 
# Main logic - infinite loop
while true
do
 
	show_menus
	read_options
done
