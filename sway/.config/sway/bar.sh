#!/bin/sh

RED="\e[1;31m"
YELLOW="\e[1;33m"
GREEN="\e[1;32m"
BASE_COLOR='\e[0m'

DATE=$(date "+%d/%m/%Y %H:%M")
NETWORK_NAME=$(nmcli -t -f NAME c show --active | head -n 1)
CONNECTION=$(nmcli -t -f CONNECTIVITY general)
CONNECTION_COLOR=""

#echo -e "${connection_color} $network_name ${base_color}| /: $root_percent% used | $date_root_colorted "
if [[ "$CONNECTION" == *"full"* ]]; then
				CONNECTION_COLOR='\e[32m'
else
				CONNECTION_COLOR='\e[31m'
				NETWORK_NAME="None"
fi

NET_STATUS=$"$CONNECTION_COLOR$NETWORK_NAME$BASE_COLOR"

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
    BAT_STATUS=$RED
elif [[ $CHARGE -lt 60 ]]; then
    # yellow-ish
    BAT_STATUS=$YELLOW
elif [[ $CHARGE -lt 100 ]]; then
    # green-ish
    BAT_STATUS=$GREEN
fi

BAT_STATUS=$"${ICON}${BAT_STATUS}${CHARGE}%\e[0m" 

# Root Stats
ROOT_PERCENT=$(df --output=pcent / | tail -n 1 | tr -d ' %')
ROOT_COLOR=""
# Color root based on percent used
if [[ $ROOT_PERCENT -lt 30 ]]; then
    # red-ish
    ROOT_COLOR=$GREEN
elif [[ $ROOT_PERCENT -gt 60 ]]; then
    # yellow-ish
    ROOT_COLOR=$YELLOW
elif [[ $ROOT_PERCENT -gt 75 ]]; then
    # green-ish
    ROOT_COLOR=$RED
fi

ROOT_STATUS=$"$ROOT_COLOR$ROOT_PERCENT% used $BASE_COLOR"

# Volume Module
VOLUME=$"$(pamixer --get-volume)"
MUTED=$"$(pamixer --get-mute)"
VOLUME_ICON=""
VOLUME_COLOR=""

#Different icons based on if muted or not
if [[ "$MUTED" == *"true"* ]]; then
				VOLUME_ICON=""
else
				VOLUME_ICON="󰕾"
fi

# Color based on volume amount
if [[ $VOLUME = 0 ]]; then
				VOLUME_COLOR=$RED
elif [[ $VOLUME -gt 90 ]]; then
				VOLUME_COLOR=$RED
else
				VOLUME_COLOR=$BASE_COLOR
fi

VOLUME_STATUS="$VOLUME_ICON $VOLUME_COLOR$VOLUME%$BASE_COLOR"

# Final formated output.
echo -e $"$NET_STATUS|$BAT_STATUS|$VOLUME_STATUS|/:$ROOT_STATUS|$DATE"

