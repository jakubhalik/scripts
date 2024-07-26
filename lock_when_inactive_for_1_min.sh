#!/bin/bash

if ! command -v xprintidle &> /dev/null
then
    echo "xprintidle could not be found. Please install it first."
    exit
fi

if ! command -v xtrlock &> /dev/null
then
    echo "xtrlock could not be found. Please install it first."
    exit
fi

idle_time=$((10 * 60 * 100))

while true; do
    idle=$(xprintidle)
    
    if [ "$idle" -ge "$idle_time" ]; then
        xtrlock
    fi
    
    sleep 60
done
