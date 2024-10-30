#/bin/bash

#  Copyright (c) 2024 Sean L. Ryle
#
#  This library is free software; you can redistribute it and/or
#  modify it under the terms of the GNU Lesser General Public
#  License as published by the Free Software Foundation; either
#  version 2.1 of the License, or (at your option) any later version.
#  See the file COPYING included with this distribution for more
#  information.

####################################
##       Required Variables       ##
####################################
# Absolute path to this script. /home/user/bin/foo.sh
SCRIPT=$(readlink -f $0)
# Absolute path this script is in. /home/user/bin
SCRIPTPATH=$(dirname $SCRIPT)
source "$SCRIPTPATH/global.sh"
ME=$(basename $0)

####################################
##           Functions            ##
####################################


####################################
##       Main Functionality       ##
####################################

if [[ ! set_permissions ]];
then
	echo "ERROR: Permissions issue.  Exiting"
	exit 1
fi

get_cfg "$ME"
get_menutitle
get_menuitems

while true
do
    SPACER=""
    MENU_NUMBER=0
	USER_INPUT=0;
	clear;
	echo ""
	echo $MENU_TITLE

    for (( i=1; i<${#FUNCTIONS[@]}; i++ ));
    do
       if [ $i -lt 10 ];
       then
         SPACER=" "
       else
         SPACER=""
       fi
       echo "$SPACER $i) ${FUNCTIONS[$i]}"
    done

	SELECTION=0
	read -e -p "Selection: " SELECTION
	
	execute_selection $SELECTION

	if [[ ! $? -eq 255 ]];
	then
		read -p "Press any key to return to the menu..." foo
	fi
	
done
