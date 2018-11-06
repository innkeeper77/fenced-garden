#!/bin/bash
# Garden Control: Bash script for menu driven control over restricted accounts
# locking.sh - subscript for locking accounts
# ----------------------------------

# Variables
EDITOR=nano
PASSWD=/etc/passwd
RED='\033[0;41;30m'
STD='\033[0;0;39m'
 

# Functions
pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}

show_menus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~"	
	echo " ACCOUNT LOCK/UNLOCK "
	echo "~~~~~~~~~~~~~~~~~~~~~~"
	echo "1. Choose User"
	echo "2. Cancel"
}

read_options(){
	local choice
	read -p "Enter choice [ 1 - 2] " choice
	case $choice in
		1) chooser ;;
		2) exit 0 ;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

lock() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~"	
	echo "     ACCOUNT LOCK     "
	echo "~~~~~~~~~~~~~~~~~~~~~~"
	echo "You chose to lock $account"
	echo "1. Permanent lock"
	# echo "2. Timed lock" ###Not yet implemented
	echo "2. Cancel"
	#
	local choice
	read -p "Enter choice [ 1 - 2] " choice
	case $choice in
	1)  clear
		sudo passwd -l $account
		echo "$account permanently locked" 
		pause
		exit 0 ;;
	# 2) echo "Not yet implemented, sorry" ;;
	2) exit 0 ;;
	*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

unlock() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~"	
	echo "    ACCOUNT UNLOCK    "
	echo "~~~~~~~~~~~~~~~~~~~~~~"
	echo "You chose to unlock $account"
	echo "1. Continue"
	echo "2. Cancel"
	#
	local choice
	read -p "Enter choice [ 1 - 2] " choice
	case $choice in
	1)  clear
		sudo passwd -u $account
		echo "$account unlocked" 
		pause
		exit 0 ;;
	2) exit 0 ;;
	*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}


chooser(){
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~"	
	echo "     CHOOSE USER      "
	echo "~~~~~~~~~~~~~~~~~~~~~~"
	echo "Which user account is to be locked or unlocked?"
	PS3="Please select username:"
		select account in $(< restrictedusers)
		do
				clear
				echo "~~~~~~~~~~~~~~~~~~~~~~"	
				echo " ACCOUNT LOCK/UNLOCK "
				echo "~~~~~~~~~~~~~~~~~~~~~~"
				echo "1. Lock"
				echo "2. Unlock"
				echo "3. Cancel"
				#
				local choice
				read -p "Enter choice [ 1 - 3] " choice
				case $choice in
				1) lock ;;
				2) unlock ;;
				3) exit 0 ;;
				*) echo -e "${RED}Error...${STD}" && sleep 2
				esac
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
