#!/bin/bash

# --- 1. Get Date and Time ---
DATE_TIME=$(date '+%a %b %d, %H:%M:%S')
INDIA_DATE_TIME=$(TZ='Asia/Kolkata' date '+%H:%M:%S')

VOLUME_RAW=$(pamixer --get-volume)
VOLUME_PERCENT=$(echo "$VOLUME_RAW" | awk '{print $NF}' | tr -d '/')

if [ "$(pamixer --get-mute)" == "true" ]; then
VOLUME_INFO="Volume: Muted (${VOLUME_PERCENT})"
elif [ -n "$VOLUME_PERCENT" ]; then
VOLUME_INFO="Volume: ${VOLUME_PERCENT}"
else
VOLUME_INFO="Volume: Cannot read"
fi

# --- 2. Get Battery Information ---
BATTERY_CAP=$(cat /sys/class/power_supply/BAT1/capacity 2>/dev/null)
BATTERY_STATUS=$(cat /sys/class/power_supply/BAT1/status 2>/dev/null)

BATTERY_INFO="Battery: ${BATTERY_CAP}% (${BATTERY_STATUS})"

# --- 3. Get Brightness Level ---
# Try to find the first available backlight device and read current/max values
BRIGHT_CURRENT=$(cat /sys/class/backlight/*/actual_brightness 2>/dev/null | head -n 1)
BRIGHT_MAX=$(cat /sys/class/backlight/*/max_brightness 2>/dev/null | head -n 1)

BRIGHTNESS_PERCENT=$(( $BRIGHT_CURRENT * 100 / $BRIGHT_MAX ))
BRIGHTNESS_INFO="Brightness: ${BRIGHTNESS_PERCENT}%"

WORKSPACE="Workspace $(hyprctl activewindow | grep 'workspace: ' | cut -d' ' -f2)"

NOTIFICATION_BODY_1="${DATE_TIME} (${INDIA_DATE_TIME})\n${VOLUME_INFO}\n${BATTERY_INFO}\n${BRIGHTNESS_INFO}"

notify-send -a 'sys-status' -t 5000 -i 'dialog-information' "$WORKSPACE"  "$NOTIFICATION_BODY_1"

# --- 4. Get Wi-Fi Status (Requires NetworkManager/nmcli) ---
WIFI_CONN=$(nmcli -t -f active,ssid dev wifi | awk -F: '$1 ~ /^yes/ {print $2}')
WIFI_INFO="Wi-Fi: ${WIFI_CONN}"

# --- 5. Assemble and Send Notification ---
NOTIFICATION_BODY_2="${WIFI_INFO}"

# notify-send -a 'sys-status' -t 5000 -i 'dialog-information' 'System Status' "$NOTIFICATION_BODY_2"
