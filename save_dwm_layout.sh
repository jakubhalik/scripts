#!/bin/bash
mkdir -p ~/.dwm_session

# Save the list of open windows with their properties
wmctrl -lG > ~/.dwm_session/windows
