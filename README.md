# fenced-garden
Simple linux administration interface for parents: Control access to specific application groups at will.

Created for a family member to enable or disable specific groups (categories) of games or other software at will in order to remove distractions as needed. 

Cleaned up documentation and details coming soon, as the system was initially developed only for a single use. 

Reccomended setup: Save scripts to /opt, and add an alias to fgwrapper.sh to start the interface. Restricted rograms will need to be added to specific groups manually. Restricted groups are saved in the restrictedgroups.txt file, and a selection of sample groups you may choose to use are included in that file. This may be changed as needed.

Tested on Ubuntu 16.04, written entirely in bash. MIT licensed, attribution appriciated!
