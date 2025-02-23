#!/bin/bash

devices=$(bluetoothctl devices | awk '{print $2, $3, $4, $5, $6}' | sed 's/ $//')

selected_device=$(echo -e "$devices" | rofi -dmenu -p "Bluetooth Devices")

if [ -n "$selected_device" ]; then
    mac_address=$(echo "$selected_device" | awk '{print $1}')
    bluetoothctl connect "$mac_address"
fi
