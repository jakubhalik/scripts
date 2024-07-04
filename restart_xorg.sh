#!/bin/bash

# Save the current DWM session
/home/x/.dwm_session/save_dwm_layout.sh

# Restart Xorg (this might log you out depending on your setup)
sudo systemctl restart display-manager.service

# Restore the DWM session after restart (you might need to add a delay)
/home/x/.dwm_session/restore_dwm_layout.sh
