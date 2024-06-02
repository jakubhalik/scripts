#!/bin/bash
WALLPAPER_DIR="$HOME/do/w"
WALLPAPERS=($(
	find "$WALLPAPER_DIR" -type f \( -name '*.jpg' -o -name '*.png' \)
))
NUM_WALLPAPERS=${#WALLPAPERS[@]}

while true; do
	RANDOM_INDEX=$((RANDOM % NUM_WALLPAPERS))
	SELECTED_WALLPAPER="${WALLPAPERS[$RANDOM_INDEX]}"
	xwallpaper --zoom "$SELECTED_WALLPAPER"
	# wal is from python-pywall
	wal -i "$SELECTED_WALLPAPER"
	source "$HOME/.cache/wal/colors.sh"
	RANDOM_INTERVAL=$((RANDOM % 91 + 90))
	sleep $RANDOM_INTERVAL
done

