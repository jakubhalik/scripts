#!/bin/bash

# Save the current DWM session
/home/x/.dwm_session/save_dwm_layout.sh

# Kill the current X session
pkill -KILL -x Xorg

# Wait for a moment to ensure Xorg is killed
sleep 5

# Start a new X session
startx &

# Restore the DWM session after restart (you might need to add a delay)
sleep 10  # Adjust the sleep time as needed# Restore the DWM session after restart (you might need to add a delay)
/home/x/.dwm_session/restore_dwm_layout.sh
