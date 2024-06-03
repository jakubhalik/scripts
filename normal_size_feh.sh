#!/bin/bash

# Get terminal size in pixels; might require `xdotool` or similar tool if standard methods fail
term_width=$(tput cols)
term_height=$(tput lines)

# Convert terminal size from characters to pixels assuming approx 8x16 per character (adjust as needed)
pixel_width=$((term_width * 8))
pixel_height=$((term_height * 16))

# Run feh with geometry to fit the terminal window size
feh --auto-zoom --geometry ${pixel_width}x${pixel_height}+0+0 "$@"
