#!/bin/bash

/home/x/.dwm_session/save_dwm_layout.sh

pkill xinit

sleep 5

startx &

sleep 10
/home/x/.dwm_session/restore_dwm_layout.sh
