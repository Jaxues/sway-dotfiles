#!/bin/sh
date_formatted=$(date "+%d/%m/%Y %H:%M")
root_percent=$(df --output=pcent / | tail -n 1 | tr -d ' %')
network_name=$(nmcli -t -f NAME c show --active | head -n 1)
connection=$(nmcli -t -f CONNECTIVITY general)
base_color='\e[0m'

## if statement for connection as well as percentage of root used 
if [ "$connection"="full" ] 
then
				connection_color='\e[32m'
fi

if [ '$connection'='none' ]
then
				connection_color='\e[31m'
fi
echo " $network_name | /: $root_percent% used | $date_formatted "
#echo -e "${connection_color} $network_name ${base_color}| /: $root_percent% used | $date_formatted "
