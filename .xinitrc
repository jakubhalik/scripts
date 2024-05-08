#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then

    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then

    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

WALLPAPER_DIR="do/w"
WALLPAPERS=($(
	find "$WALLPAPER_DIR" -type f \( -name '*.jpg' -o -name '*.png' \)
))
NUM_WALLPAPERS=${#WALLPAPERS[@]}
while true; do
	RANDOM_INDEX=$((RANDOM % NUM_WALLPAPERS))
	SELECTED_WALLPAPER="${WALLPAPERS[$RANDOM_INDEX]}"
	xwallpaper --zoom "$SELECTED_WALLPAPER"
	wal -i "$SELECTED_WALLPAPER"
	RANDOM_INTERVAL=$((RANDOM % 91 + 90))
	sleep $RANDOM_INTERVAL
done &

xcompmgr &
zb &
exec dwm &
st


