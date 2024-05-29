#!/bin/bash
read -p "Enter the youtube channel URL (the one which ends with videos): " URL
yt-dlp -o "%(title)s.%(ext)s" -ciw -v --all-subs --embed-subs --merge-output-format mp4 "$URL"
