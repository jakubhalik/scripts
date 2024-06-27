#!/bin/bash

seconds=0

while true; do
    clear
    printf "%02d:%02d:%02d\n" $((seconds/3600)) $((seconds/60%60)) $((seconds%60))
    sleep 1
    seconds=$((seconds+1))
done
