#!/bin/bash 
# Version 0.0.2
# Set $1- Number file , last octet for File
# Set $2 - changing password for user ubuntu 
# Set $3 - set hostname
# Set $4 - set name of Management switch

if [ -z $4 ]; then 
	echo "!!!!!!"
	echo "Set 4 variables "
	echo "For example , ./gen-files.sh 100 test NODE25 NETWORK"
	echo "!!!!!!"
	exit 10
fi

lastoctet=$1



echo "--Creating Network ..."
sed  "s/LASTOCTET/$1/" net.template >> net$1.yaml



echo "--Creating cloud-init file ..."

sed  "s/NETCONTENT/$(base64 -w 0 net$lastoctet.yaml)/" cloud-init.template >> cloud-init$1.yaml
sed -i  "s/PASSWORD/$2/" cloud-init$1.yaml

echo "-- Output cloud-init$1.yaml"
cat cloud-init$1.yaml

echo "-----------------------------------------------------"

sed  "s/USERDATA/$(base64 -w 0 cloud-init$lastoctet.yaml)/" ubuntu.template >> ubuntu$1.json
sed  -i "s/NODENAME/$3/" ubuntu$1.json

echo "-- Output ubuntu$1.json"

cat ubuntu$1.json 


echo "-----------------------------------------------------"


