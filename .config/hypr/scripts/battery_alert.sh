#!/bin/bash

# Configurable thresholds
LOW_BATTERY=20
CRITICAL_BATTERY=10
SLEEP_TIME=90 # Check every minute

while true; do
    # Get battery percentage using upower
    #BATTERY_PATH=$(upower -e | grep battery)
   # PERCENTAGE=$(upower -i $BATTERY_PATH | grep percentage | awk '{print $2}' | tr -d '%')
   # STATE=$(upower -i $BATTERY_PATH | grep state | awk '{print $2}')
    PERCENTAGE=$(cat /sys/class/power_supply/BAT1/capacity 2>/dev/null)
    STATE=$(cat /sys/class/power_supply/BAT1/status 2>/dev/null)

    # If discharging and below thresholds
    if [ "$STATE" = "Discharging" ]; then
        if [ "$PERCENTAGE" -le "$CRITICAL_BATTERY" ]; then
            # notify-send -t 5000 -u normal "Critical Battery" --icon=/usr/share/icons/MacTahoe/status/16/battery-low.svg "Battery is at ${PERCENTAGE}%! Plug in now."
            notify-send -t 5000 -u normal "" --icon=/usr/share/icons/MacTahoe/status/16/battery-low.svg "Battery: ${PERCENTAGE}%!."
        elif [ "$PERCENTAGE" -le "$LOW_BATTERY" ]; then
            # notify-send -t 5000 -u normal "Low Battery" --icon=/usr/share/icons/MacTahoe/status/16/battery-low.svg "Battery is at ${PERCENTAGE}%."
            notify-send -t 5000 -u normal "" --icon=/usr/share/icons/MacTahoe/status/16/battery-low.svg "Battery: ${PERCENTAGE}%"
        fi
    fi

    sleep $SLEEP_TIME
done


