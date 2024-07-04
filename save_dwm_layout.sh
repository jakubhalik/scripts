#!/bin/bash
mkdir -p /home/x/.dwm_session

# Save the list of open windows with their properties
wmctrl -lG > /home/x/.dwm_session/windows
