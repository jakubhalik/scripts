#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or use sudo"
  exit
fi

cd /home/x/d/g/gh/scripts || exit

names=("cloud" "localgitlab" "localcloud" "friends" "localfriends")

for name in "${names[@]}"; do
  file="${name}.jakubhalik.org"
  if [ -f "$file" ]; then
    sed -i '/proxy_read_timeout\|proxy_connect_timeout\|proxy_send_timeout\|send_timeout/s/300/1d/' "$file"
  else
    echo "File $file does not exist, skipping."
  fi
done

