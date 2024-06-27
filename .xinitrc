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
$HOME/d/g/gh/scripts/wallpaper_switching.sh &
$HOME/d/g/gh/scripts/deleting_what_bullshit_programs_create.sh &
xcompmgr -c -f -n &
# If you do not want the "anti-tearing" -c -f -n setting just kill the xcompmgr and start xcompmgr &
exec dwm
st 

# Uncomment the 2 lines below if u don't want your screen to go black for rest
# xset s off
# xset -dpms

