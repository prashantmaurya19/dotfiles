#!/bin/bash

# 1. Fetch paired devices and filter for likely audio devices
# bluetoothctl paired-devices returns: Device XX:XX:XX:XX:XX:XX Name
# We pipe this to fzf to let you pick one.
device=$(bluetoothctl devices | fzf)

# 2. Extract the MAC address (the second column)
mac_address=$(echo "$device" | awk '{print $2}')

# 3. Extract the Name for the notification
device_name=$(echo "$device" | cut -d ' ' -f 3-)

# 4. Check if a selection was made
if [ -z "$mac_address" ]; then
  exit 0
fi

# 5. Attempt to connect
echo "Connecting to $device_name ($mac_address)..."
notify-send "Bluetooth" "Connecting to $device_name..."

if bluetoothctl connect "$mac_address"; then
  notify-send "Bluetooth" "Successfully connected to $device_name" -i audio-headphones
else
  notify-send "Bluetooth" "Failed to connect to $device_name" -u critical
fi
