#!/bin/sh
DATE_BAT_STATUSTED=$(date "+%d/%m/%Y %H:%M")
ROOT_PERCENT=$(df --output=pcent / | tail -n 1 | tr -d ' %')
NETWORK_NAME=$(nmcli -t -f NAME c show --active | head -n 1)
CONNECTION=$(nmcli -t -f CONNECTIVITY general)
BASE_COLOR='\e[0m'
CONNECTION_COLOR=""

#echo -e "${connection_color} $network_name ${base_color}| /: $root_percent% used | $date_formatted "
if [[ "$CONNECTION" == *"full"* ]]; then
				CONNECTION_COLOR='\e[32m'
else
				CONNECTION_COLOR='\e[31m'
				NETWORK_NAME="None"
fi
# Getting the data and initializing an array.
BATTERY_INFO=($( acpi | awk -F',' '{ print $0 }'))

# Formatting helpers
CHARGE=$((${BATTERY_INFO[3]//%,}))
ICON=""
BAT_STATUS=""

# Format battery icon, depending on the status.
if [[ "${BATTERY_INFO[2]}" == *"Charging"* ]]; then
    ICON="  " # Plug icon, font awesome.
else
    ICON=" " # Car Battery icon, font awesome
fi

# Format charge & color depending on the status.
if [[ $CHARGE -lt 30 ]]; then
    # red-ish
    BAT_STATUS="\e[1;31m"
elif [[ $CHARGE -lt 60 ]]; then
    # yellow-ish
    BAT_STATUS="\e[1;33m"
elif [[ $CHARGE -lt 100 ]]; then
    # green-ish
    BAT_STATUS="\e[1;32m"
fi

if [[ $charge -lt 30 ]]; then
    # red-ish
    format="\e[1;31m"
elif [[ $charge -lt 60 ]]; then
    # yellow-ish
    format="\e[1;33m"
elif [[ $charge -lt 100 ]]; then
    # green-ish
    format="\e[1;32m"
fi

BAT_STATUS=$"${ICON}${BAT_STATUS}${CHARGE}%" 

# Final formatted output.
echo -e " $CONNECTION_COLOR$NETWORK_NAME \e[0m| $BAT_STATUS \e[0m|/: $ROOT_PERCENT% used | $DATE_BAT_STATUSTED "

