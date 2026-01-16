#!/bin/sh
DATE=$(date "+%d/%m/%Y %H:%M")

# Module for network
NETWORK_NAME=$(nmcli -t -f NAME c show --active | head -n 1)
RADIO_WIFI=$(nmcli radio wifi)
CONNECTION=$(nmcli -t -f CONNECTIVITY general)
CONNECTION_ICON=""

#echo -e "${connection_color} $network_name ${base_color}| /: $root_percent% used | $date_root_colorted "
if [[ "$CONNECTION" == *"full"* ]]; then
				CONNECTION_ICON=" "
elif [[ "$RADIO_WIFI" == *"disabled" ]]; then
				CONNECTION_ICON="󰀝 "
				NETWORK_NAME="Airplane mode"
else
				NETWORK_NAME="None"
				CONNECTION_ICON="󰖪 "
fi

NET_STATUS="$CONNECTION_ICON  $NETWORK_NAME"


# Getting the data and initializing an array.
BATTERY_INFO=($( acpi | awk -F',' '{ print $0 }'))

# Formatting helpers
CHARGE=$((${BATTERY_INFO[3]//%,}))
ICON=""
BAT_STATUS=""

# Format battery icon, depending on the status.
if [[ "${BATTERY_INFO[2]}" == *"Charging"* ]]; then
				ICON=" " # Plug icon, font awesome.
elif [[ $CHARGE -lt 25 ]]; then
				ICON="  "
elif [[ $CHARGE -lt 50 ]]; then
				ICON="  "
elif [[ $CHARGE -lt 75 ]]; then
				ICON="  "
else
    ICON="  " # Car Battery icon, font awesome
fi

# Format charge & color depending on the status.
BAT_STATUS="$ICON $CHARGE%" 

# Root Stats
ROOT_PERCENT=$(df --output=pcent / | tail -n 1 | tr -d ' %')


ROOT_STATUS=$"$ROOT_PERCENT% used"

# Volume Module
VOLUME=$"$(pamixer --get-volume)"
MUTED=$"$(pamixer --get-mute)"
VOLUME_ICON=""

#Different icons based on if muted or not
if [[ "$MUTED" == *"true"* ]]; then
				VOLUME_ICON="  "
else
				VOLUME_ICON="󰕾 "
fi


VOLUME_STATUS="$VOLUME_ICON $VOLUME%"

# Brightness Module
BRIGHTNESS=$(brightnessctl info | awk -F'[()%]' '/Current brightness/ {print 0+$2}')
BRIGHTNESS_ICON="󰃠 "

BRIGHTNESS_STATUS="$BRIGHTNESS_ICON $BRIGHTNESS%"
# Bluetooth Module
BLUETOOTH=$(systemctl is-active "bluetooth.service") # Bluetoothctl get status or something
BLUETOOTH_ICON=""
# If statement based on status
if [[ "$BLUETOOTH" == "active" ]]; then
				BLUETOOTH_ICON="󰂯"
else
				BLUETOOTH_ICON="󰂲"
fi

BLUETOOTH_STATUS="$BLUETOOTH_ICON $BLUETOOTH"
# Final formated output.

# Laptop statusline
echo "$NET_STATUS | $VOLUME_STATUS | $BRIGHTNESS_STATUS | $BLUETOOTH_STATUS | $BAT_STATUS |$ROOT_PERCENT% of root used | $DATE"
 

# Simplified status icons
#echo "$NET_STATUS | $ROOT_PERCENT% of root used | $DATE"

