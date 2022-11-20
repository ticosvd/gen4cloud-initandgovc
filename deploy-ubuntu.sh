#!/bin/bash
# Version 0.0.2
# $1 - fourth octet 
# $2 - node name
#

if [ -z $2 ];  then
	echo " Usage - ./deploy-ubuntu.sh 4th_octet name_of_vm "
	echo " Example, ./deploy-ubuntu.sh 20 node20" 
	exit 10
fi



govc import.ova -options=ubuntu$1.json /home/troot/DISK500/IMAGES/jammy-server-cloudimg-amd64.ova
govc vm.change  -vm=$2 -c 2
govc vm.change  -vm=$2 -m=2048
govc vm.disk.change -vm=$2 -disk.label "Hard disk 1" -size 40G
govc vm.info --json  $2
govc vm.power -on $2
