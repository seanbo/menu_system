#!/bin/bash

#  Copyright (c) 2024 Sean L. Ryle
#
#  This library is free software; you can redistribute it and/or
#  modify it under the terms of the GNU Lesser General Public
#  License as published by the Free Software Foundation; either
#  version 2.1 of the License, or (at your option) any later version.
#  See the file COPYING included with this distribution for more
#  information.

source $SETUP_DIR/../cfg/global.cfg

####################################
## Installation and apt functions ##
####################################

function download_add_key()
{
	echo "Downloading and adding GPG key"
	curl -sS "$1" | sudo apt-key add -
}

function apt_key()
{
	echo "Adding GPG Key: $1"
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys "$1"
}

function apt_clean()
{
  echo "Clean up packages for apt-get"
  sudo apt-get clean
}

function remove_package
{
	echo "Removing package: $1"
	sudo apt-get remove "$1"
}

function apt_update()
{
  echo "Running apt update"
  sudo apt update	
}

function add_repo()
{
	echo "Adding Package repository: $1"
	sudo add-apt-repository -y "$1"
}

function add_repo_list_d()
{
	echo "Adding Package repository: $1"
	echo "$1" | "sudo tee /etc/apt/sources.list.d/$2.list"
}

function install_package()
{
  echo "Installing package: $1"
  sudo apt -f -y install "$1"
}

function install_repo_package()
{
  add_repo "$1"  
  apt_update
  install_package "$2"
}

####################################
##            Unused              ##
####################################

##NOTHING BEYOND HERE IS IMPLEMENTED YET (or some will be removed later)
#HARD_FAIL=255
#SOFT_FAIL=1
#CONTINUE_ON_FAIL=0



##System Setup Global Functions
#function hard_fail
#{
  #if [ "$#" -ne 0 ];
  #then
    #echo "FAILURE: $1"
  #else
    #echo "FAILURE: Exiting"
  #fi
  #exit $HARD_FAIL
#}

#function can_continue
#{
  #CATEGORY=$1
  #if [ ! -e "$CATEGORY" ];
  #then
    #DIRECTORY=$(eval echo \$${CATEGORY}_DIR)
    #if [[ "$DIRECTORY" == "" ]];
    #then
      ##if can continue
      #echo ""
      ##Need to finish this
    #fi
  #fi
  
  ##Something is wildly wrong.  Likely, the "CATEGORY" esd not provided, we will hard_fail here
  #hard_fail "No CATEGORY provided"
#}

#function check_dir_exists
#{
  #CATEGORY=$1
  #DIRECTORY=$(eval echo \$${CATEGORY}_CAN_COTINUE_ON_FAIL)
  #if [ ! -e "$DIRECTORY" ];
  #then
    #hard_fail "Missing directory name"
  #else
    #if [ can_continue ];
    #then
      #echo ""
    #else
      #echo ""
    #fi
  #fi
  
#}

#function check_file_exists
#{
  #echo $0
#}

#function download_file
#{
  #echo $0
#}

#function make_symlink
#{
  #echo $0
#}

#function loop_copy
#{
	#echo $0
#}

#function repo_add
#{
  #echo $0
#}

#function apt_get_install
#{
	##Here we will apt-get update and then apt-get install
	#echo $0
#}

#function make_download_dir
#{
	#echo "Checking downloads directory"
	#if [ -d $DOWNLOADS_DIR ];
	#then
	  #echo "Removing existing files"
	  ##Let's BE SURE, we are not removing all files in /
	  #if [[ $DOWNLOADS_DIR != "/" ]];
	  #then
	    #rm -f $DOWNLOADS_DIR/*
	  #else
	    #echo "ERROR: Please check DOWNLOADS_DIR variable. It is currently set to /"
	    #exit $HARD_FAIL_EXIT_CODE
	  #fi
	#else
	  #echo "Creating downloads dir"
	  #mkdir -p $DOWNLOADS_DIR
	  #if [ ! check_dir_exists "$DOWNLOADS_DIR" ];
	  #then
	    #echo "ERROR: Directory not created: $DOWNLOADS_DIR"
	    #return 1
	  #fi
	#fi
  ##if we got here, something really isn't right
  #hard_fail
#}

