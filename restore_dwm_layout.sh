#!/bin/bash

# Ensure DWM is running before restoring the layout
sleep 5  # Adjust the sleep time as needed

# Restore the window properties
while IFS= read -r line; do
    wm_id=$(echo $line | awk '{print $1}')
    x=$(echo $line | awk '{print $3}')
    y=$(echo $line | awk '{print $4}')
    width=$(echo $line | awk '{print $5}')
    height=$(echo $line | awk '{print $6}')
    
    wmctrl -ir $wm_id -e 0,$x,$y,$width,$height
done < /home/x/.dwm_session/windows
