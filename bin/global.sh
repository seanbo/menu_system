#!/bin/bash

#  Copyright (c) 2024 Sean L. Ryle
#
#  This library is free software; you can redistribute it and/or
#  modify it under the terms of the GNU Lesser General Public
#  License as published by the Free Software Foundation; either
#  version 2.1 of the License, or (at your option) any later version.
#  See the file COPYING included with this distribution for more
#  information.


####################################
##        Global Variables        ##
####################################
ME_SCRIPT=$(readlink -f -- "$0")
SETUP_DIR="$(dirname $ME_SCRIPT)"
CONFIG_DIR="$SETUP_DIR/../cfg"
BIN_DIR="$SETUP_DIR"
SOURCE_FILES_DIR="$SETUP_DIR/files"

#Load any user defined code
source "$SETUP_DIR/userfunc.sh"

####################################
##         Menu Variables         ##
####################################
MENU_TITLE=""
MENU_ACTION=""
declare -a FUNCTIONS=("Not Used")
declare -a SCRIPTS=("false")

####################################
##  Software related Variables    ##
####################################
JQ_VERSION=""

####################################
##       General functions        ##
####################################
function get_cfg() {

	CFG_FILE="$(echo $1|cut -d"." -f1).cfg"
	CONFIG_FILE="$CFG_FILE"
}

function get_menuitems() {

	IFSBACK=$IFS
		IFS=$'\n'
		FUNCTIONS+=($(grep "menuitem" "$CONFIG_DIR/$CONFIG_FILE" | grep -v "^#"|cut -d":" -f2))
		SCRIPTS+=($(grep "menuitem" "$CONFIG_DIR/$CONFIG_FILE" | grep -v "^#"|cut -d":" -f3))
	IFS=$IFSBACK
}

function get_menutitle() {

	IFSBACK=$IFS
		IFS=: read FOO MENU_TITLE MENU_ACTION <<< $(grep menutitle $CONFIG_DIR/$CONFIG_FILE | grep -v "^#")
	IFS=$IFSBACK
}

function is_jq_installed() {

	echo "Checking to see if jq is installed"
	JQ_VERSION=$(apt-cache policy jq|grep Installed|awk '{print $2}')
	if [[ "$JQ_VERSION" == "(none)" ]];
	then
		echo "jq is not installed"
		return 1
	fi
	echo "jq version: $JQ_VERSION"
	return 0
	
}

function check_prereqs() {

	echo -n "Checking jq: "
	if [[ ! is_jq_installed ]];
	then
		echo "not installed.  Installing..."
		install_package "jq"
		return $?
	else
		echo "ok"
		return 0
	fi
}

function execute_selection {

	local SELECTION=$1
	local SCRIPT_NAME=${SCRIPTS[$SELECTION]}

	declare -a EXECUTE

	if [[ $SCRIPT_NAME == "exit" || $SCRIPT_NAME == "" || $SCRIPT_NAME == "false" ]];
	then
	  exit 255
	fi

	if [[ $SCRIPT_NAME == "run-all.sh" ]];
	then
		ACCEPTANCE="N"  #Default to no save
		read -p "Are you sure you want to run ALL? [y/N]: " ACCEPTANCE
		if [[ "$ACCEPTANCE" == "y" || "$ACCEPTANCE" == "Y" ]];
		then
			EXECUTE=("${SCRIPTS[@]}")
			local REMOVE=("run-all.sh" "exit" "false")
			for i in "${REMOVE[@]}"
			do
				EXECUTE=( ${EXECUTE[@]/$i} )
			done
		else
			echo "Skipped"
		fi
	else
		#Single script added to array
		EXECUTE[0]="$SCRIPT_NAME"
	fi

    for (( i=0; i < ${#EXECUTE[@]}; i++ ));
    do
		CALLING="${EXECUTE[$i]}"
		local COMMAND=""
		if [[ "${CALLING:0:1}" == "/" ]]; then
			COMMAND="$CALLING"
		else
			COMMAND="$BIN_DIR/$CALLING"
		fi

		eval $COMMAND
    done

}

function set_permissions() {

	if [[ -d "$BASE_DIR" ]] && [[ ! -e "$BASE_DIR" ]];
	then
		chmod 750 $BASE_DIR/*.sh
		if [[ $? -ne 0 ]];
		then
			echo "There was a problem setting script permissions"
			return 1
		fi
		
		chmod 644 $BASE_DIR/*.cfg
		if [[ $? -ne 0 ]];
		then
			echo "There was a problem setting cfg file permissions"
			return 1
		fi
	fi
	
	echo "There was a problem setting permissions"
	return 1
}

####################################
##        Screen functions        ##
####################################

