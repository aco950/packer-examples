#!/usr/bin/env bash
#
# run.sh
#
# Creates a KVM virtual machine image via Packer.
#
# Usage: ./run.sh
#

workdir="/mnt/packer/test-01"

_build() {
	if [ -d "$workdir" ]
	then
		# Packer will complain if this directory exists beforehand:
		sudo rm -rfv "$workdir"
	fi

	# Log output:
	export PACKER_LOG=1 
	export PACKER_LOG_PATH=packer.log 

	packer build packer.json 
}

_error_msg() {
	echo "Usage: ./run.sh"
	echo "This script does not accept arguments!"
	echo "Exiting now."
	sleep 1 
}

# This script does not accept arguments:
if [ ! -z "$1" ]
then
	_error_msg
	exit 1
else
	_build
fi

