#!/bin/bash
for file in *.mkv; do
    ffmpeg -i "$file" -c copy "${file%.mkv}.mp4"
done
