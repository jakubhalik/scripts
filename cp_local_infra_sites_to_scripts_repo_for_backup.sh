#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root or use sudo"
    exit
fi

names=("gitlab" "cloud" "excalidraw" "friends")

for i in "${!names[@]}"; do

    name="${names[$i]}"
  
    cp /etc/nginx/sites-available/local${name}.jakubhalik.org ~/d/g/gh/scripts/local${name}.jakubhalik.org

    find ~/d/g/gh/scripts/local${name}.jakubhalik.org

done

