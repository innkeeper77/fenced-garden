#!/bin/bash
# Garden Control: Bash script for menu driven control over restricted accounts
# users.sh - subscript for adding/removing restricted accounts
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
	echo "    Create/Delete     "
	echo " Restricted Accounts  "	
	echo "~~~~~~~~~~~~~~~~~~~~~~"
	echo "1. Create"
	echo "2. Delete"
	echo "3. Cancel"
}

read_options(){
	local choice
	read -p "Enter choice [ 1 - 3] " choice
	case $choice in
		1) create ;;
		2) remove ;;
		3) exit 0 ;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

create(){
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~"	
	echo "NEW RESTRICTED ACCOUNT"
	echo "~~~~~~~~~~~~~~~~~~~~~~"
	echo "1. Continue"
	echo "2. Cancel"
	local choice
	read -p "Enter choice [ 1 - 2] " choice
	case $choice in
		1) add ;;
		2) exit 0 ;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

add(){
	clear
	echo "Creating user"
	echo "Please enter username"
	read username	
	sudo adduser $username
	sudo echo "$username" >> restrictedusers
	echo "user created"
	pause
}

remove(){
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~"	
	echo "DELETE RESTRICTED ACCT"
	echo "~~~~~~~~~~~~~~~~~~~~~~"
	echo "1. Continue"
	echo "2. Cancel"
	local choice
	read -p "Enter choice [ 1 - 2] " choice
	case $choice in
		1) chooseremove ;;
		2) exit 0 ;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

chooseremove(){
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~"	
	echo "     CHOOSE USER      "
	echo "~~~~~~~~~~~~~~~~~~~~~~"
	echo "Which user is to be removed? (CONTROL+C TO ABORT)"
	PS3="Please select username:"
		select account in $(< restrictedusers)
		do
				clear
				echo "~~~~~~~~~~~~~~~~~~~~~~"	
				echo "     Are you sure?    "
				echo "~~~~~~~~~~~~~~~~~~~~~~"
				echo "Deleting $account"
				echo "1. Continue"
				echo "2. Cancel"
				#
				local choice
				read -p "Enter choice [ 1 - 2] " choice
				case $choice in
				1) deleteaccount ;;
				2) exit 0 ;;
				*) echo -e "${RED}Error...${STD}" && sleep 2
				esac
			exit 0
		done
}

deleteaccount(){
	clear
	echo "Deleting $account"
	sudo userdel -r $account
	sudo grep -v "$account" restrictedusers > restrictedusers.tmp
	sudo mv restrictedusers.tmp restrictedusers
	echo "$account deleted"
	pause
}

# Main logic - infinite loop
while true
do
	show_menus
	read_options
done

