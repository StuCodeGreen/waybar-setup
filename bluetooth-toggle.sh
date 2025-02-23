#!/bin/bash

status=$(bluetoothctl show | grep "Powered: yes")

if [ -n "$status" ]; then
    bluetoothctl power off
    notify-send "Bluetooth" "Turned OFF"
else
    bluetoothctl power on
    notify-send "Bluetooth" "Turned ON"

    # Wait for Bluetooth to initialize
    sleep 2 

    # Get last connected device
    last_device=$(bluetoothctl devices | awk 'NR==1 {print $2}')
    
    if [ -n "$last_device" ]; then
        bluetoothctl connect "$last_device"
        notify-send "Bluetooth" "Reconnected to $last_device"
    fi
fi
