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
## Installation and apt functions ##
####################################

function apt_update() {

  sudo apt update	
}

function apt_upgrade() {

	if [[ ! -z "$1" ]]; then
		ARG="-$1"
	fi

	sudo apt $ARG upgrade
}
