#!/bin/sh

# Defining color pallete
RED="#FF5555"
YELLOW="#F1FA8C"
GREEN="#50FA7B"
WHITE="#F8F8F2"
BLUE="#8BE9FD"


DATE=$(date "+%d/%m/%Y %H:%M")

# Module for network
NETWORK_NAME=$(nmcli -t -f NAME c show --active | head -n 1)
CONNECTION=$(nmcli -t -f CONNECTIVITY general)
CONNECTION_COLOR=""

#echo -e "${connection_color} $network_name ${base_color}| /: $root_percent% used | $date_root_colorted "
if [[ "$CONNECTION" == *"full"* ]]; then
				CONNECTION_COLOR=$GREEN
else
				CONNECTION_COLOR=$RED
				NETWORK_NAME="None"
fi

NET_STATUS=$"$CONNECTION_COLOR$NETWORK_NAME$WHITE"
#NET_STATUS=$"$CONNECTION_COLOR$NETWORK_NAME"


# Getting the data and initializing an array.
BATTERY_INFO=($( acpi | awk -F',' '{ print $0 }'))

# Formatting helpers
CHARGE=$((${BATTERY_INFO[3]//%,}))
ICON=""
BAT_STATUS=""

# Format battery icon, depending on the status.
if [[ "${BATTERY_INFO[2]}" == *"Charging"* ]]; then
    ICON=" " # Plug icon, font awesome.
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

BAT_STATUS=$"${ICON}${BAT_STATUS}${CHARGE}%$WHITE" 
#BAT_STATUS=$"${ICON}${BAT_STATUS}${CHARGE}%" 

# Root Stats
ROOT_PERCENT=$(df --output=pcent / | tail -n 1 | tr -d ' %')
ROOT_COLOR=""
# Color root based on percent used is opposite of Battery 
if [[ $ROOT_PERCENT -lt 30 ]]; then
    ROOT_COLOR=$GREEN
elif [[ $ROOT_PERCENT -gt 50 ]]; then
    ROOT_COLOR=$YELLOW
elif [[ $ROOT_PERCENT -gt 75 ]]; then
    ROOT_COLOR=$RED
fi

ROOT_STATUS=$"$ROOT_COLOR$ROOT_PERCENT% used$WHITE"
#ROOT_STATUS="$ROOT_COLOR$ROOT_PERCENT% used"

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

# Color based on volume amount greater than 80 likely quite loud
if [[ $VOLUME = 0 || $VOLUME -gt 80 ]]; then
				VOLUME_COLOR=$RED
elif [[ "$MUTED" == *"true"* ]]; then
				VOLUME_COLOR=$YELLOW
else
				VOLUME_COLOR=$WHITE
fi

VOLUME_STATUS="$VOLUME_ICON $VOLUME_COLOR$VOLUME% $WHITE"
#VOLUME_STATUS="$VOLUME_ICON $VOLUME_COLOR$VOLUME%"

# Brightness Module
BRIGHTNESS=$(brightnessctl info | awk -F'[()%]' '/Current brightness/ {print $2}')
BRIGHTNESS_ICON="󰃠"
BRIGHTNESS_COLOR=""

# If brightness greater than 70 likely to drain battery faster
if [[ $BRIGHTNESS -gt 70 ]]; then
				BRIGHTNESS_COLOR=$RED
else
				BRIGHTNESS_COLOR=$WHITE
fi

BRIGHTNESS_STATUS="$BRIGHTNESS_ICON $BRIGHTNESS"
# Bluetooth Module
BLUETOOTH="" # Bluetoothctl get status or something
BLUETOOTH_ICON=""
BLUETOOTH_COLOR=""
# If statement based on status
if [[ $BLUETOOTH_STATUS ]]; then
				BLUETOOTH_ICON="󰂯"

else
				BLUETOOTH_ICON="󰂲"
fi

if [[ $BLUETOOTH_STATUS ]]; then
				BLUETOOTH_COLOR=$BLUE

else
				BLUETOOTH_COLOR=$RED
fi

BLUETOOTH_STATUS="$BLUETOOTH_ICON $BLUETOOTH"
# Final formated output.
# echo "[{"full_text":"$NETWORK_STATUS","color":"$NETWORK_COLOR"},{"full_text":"$ROOT_STATUS","color":"$ROOT_COLOR"},{"full_text":"$BRIGHTNESS_STATUS","color":"BRIGHTNESS_COLOR"},{"full_text":"$VOLUME_STATUS","color":"$VOLUME_COLOR"},{"full_text":"$DATE","color":"$WHITE"}]"
# Need to use better protocol that complies with it. Use block function and parameters.

# Simplified status icons
echo $"$NETWORK_NAME | $ROOT_PERCENT% used | $DATE"
