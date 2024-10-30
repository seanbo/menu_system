#!/bin/bash

# Absolute path to this script. /home/user/bin/foo.sh
ME_SCRIPT=$(readlink -f $0)
# Absolute path this script is in. /home/user/bin
MY_PATH=$(dirname $ME_SCRIPT)
source $MY_PATH/userfunc.sh

echo "Running apt update"
apt_update

ITEMS="$(( $(apt list --upgradable 2>/dev/null | grep upgradable | wc -l) - 1 ))"

if [[ "$ITEMS" -gt 0 ]]; then
	echo "Running apt -y upgrade"
	apt_upgrade y
else
	echo "No upgradable packages found"
fi
