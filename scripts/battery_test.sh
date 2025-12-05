#!/bin/bash
battery_level=$(acpi | grep -oP '(?<=, )\d+(?=%)')

# Icon names 
ICON_LOW="battery-low"
ICON_CRIT="battery-caution"

# Notification categories 
CAT_LOW="battery.low"
CAT_CRIT="battery.critical"

if [ "$battery_level" -le 3 ]; then
    notify-send \
        -u critical \
        -a "Battery Monitor" \
        -i "$ICON_CRIT" \
        -c "$CAT_CRIT" \
        "Critical Battery (${battery_level}%)" \
        "System will suspend in 5 seconds..."
    sleep 5
    systemctl suspend
elif [ "$battery_level" -le 10 ]; then
    notify-send \
        -u normal \
        -a "Battery Monitor" \
        -i "$ICON_LOW" \
        -c "$CAT_LOW" \
        "Low Battery (${battery_level}%)" \
        "Please plug in your charger."
fi
