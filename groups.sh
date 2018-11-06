#!/bin/bash
# Garden Control: Bash script for menu driven control over restricted accounts
# groups.sh - subscript for locking/unlocking restricted application groups
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
	echo "RESTRICTED APPLICATIONS"
	echo "     CHOOSE USER      "	
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

chooser(){
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~"	
	echo "     CHOOSE USER      "
	echo "~~~~~~~~~~~~~~~~~~~~~~"
	echo "For which user account do you wish to adjust restrictions?"
	PS3="Please select username:"
		select account in $(< restrictedusers)
		do
				clear
				echo "~~~~~~~~~~~~~~~~~~~~~~"	
				echo "APP GROUP LOCK/UNLOCK "
				echo "~~~~~~~~~~~~~~~~~~~~~~"
				echo "1. Lock"
				echo "2. Unlock"
				echo "3. List current group settings"
				echo "4. Cancel"
				#
				local choice
				read -p "Enter choice [ 1 - 3] " choice
				case $choice in
				1) lock ;;
				2) unlock ;;
				3) list ;;
				4) exit 0 ;;
				*) echo -e "${RED}Error...${STD}" && sleep 2
				esac
			exit 0
		done
}

lock() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~"	
	echo "     ACCOUNT LOCK     "
	echo "~~~~~~~~~~~~~~~~~~~~~~"
	echo "You chose to lock an application group for $account"
	echo "1. Choose Group"
	echo "2. Cancel"
	#
	local choice
	read -p "Enter choice [ 1 - 2] " choice
	case $choice in
		1) chooselock ;;
		3) exit 0 ;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

unlock() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~"	
	echo "    ACCOUNT UNLOCK    "
	echo "~~~~~~~~~~~~~~~~~~~~~~"
echo "You chose to UNLOCK an application group for $account"
	echo "1. Choose Group"
	echo "2. Cancel"
	#
	local choice
	read -p "Enter choice [ 1 - 2] " choice
	case $choice in
		1) chooseunlock ;;
		2) exit 0 ;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

chooseunlock(){
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~"	
	echo "     CHOOSE GROUP     "
	echo "~~~~~~~~~~~~~~~~~~~~~~"
	echo "Which application group do you wish to UNBLOCK for $account ?"
	PS3="Please select group:"
		select group in $(< restrictedgroups)
		do
				clear
				echo "~~~~~~~~~~~~~~~~~~~~~~"	
				echo "APP GROUP LOCK/UNLOCK "
				echo "~~~~~~~~~~~~~~~~~~~~~~"
				echo "1. Unlock"
				echo "2. Cancel"
				#
				local choice
				read -p "Enter choice [ 1 - 2] " choice
				case $choice in
				1) unlocklogic ;;
				2) exit 0 ;;
				*) echo -e "${RED}Error...${STD}" && sleep 2
				esac
			exit 0
		done
}

chooselock(){
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~"	
	echo "     CHOOSE GROUP     "
	echo "~~~~~~~~~~~~~~~~~~~~~~"
	echo "Which application group do you wish to LOCK for $account ?"
	PS3="Please select group:"
		select group in $(< restrictedgroups)
		do
				clear
				echo "~~~~~~~~~~~~~~~~~~~~~~"	
				echo "APP GROUP LOCK/UNLOCK "
				echo "~~~~~~~~~~~~~~~~~~~~~~"
				echo "1. Lock"
				echo "2. Cancel"
				#
				local choice
				read -p "Enter choice [ 1 - 2] " choice
				case $choice in
				1) locklogic ;;
				2) exit 0 ;;
				*) echo -e "${RED}Error...${STD}" && sleep 2
				esac
			exit 0
		done
}

unlocklogic(){
	clear
	echo "Unrestricting $group for $account"
	sudo usermod -a -G $group $account
	clear
	echo "$group unrestricted for $account"
	pause
	exit 0
}

locklogic(){
	clear
	echo "Locking $group for $account"
	sudo deluser $account $group
	clear
	echo "$group locked for $account"
	pause
	exit 0
}

list(){
	clear
	echo "Groups $account is currently in"
	echo "Group names ' $account ' and ' cdrom ' are standard"
	sudo groups $account
	pause
	exit 0
}

# Trap CTRL+C, CTRL+Z and quit singles
# trap '' SIGINT SIGQUIT SIGTSTP
 
# Main logic - infinite loop
while true
do
 
	show_menus
	read_options
done
