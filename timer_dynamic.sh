#!/bin/bash

read -sp 'What is the timer for: ' timer_purpose

seconds=0

while true; do
    clear
    printf "$timer_purpose: %02d:%02d:%02d\n" $((seconds/3600)) $((seconds/60%60)) $((seconds%60))
    sleep 1
    seconds=$((seconds+1))
done
