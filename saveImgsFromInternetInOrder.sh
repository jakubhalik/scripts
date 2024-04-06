#!/bin/bash

echo "The starting counter number of the images I will save in a directory of your choosing will be n + 1 where n stands for the highest number filename of the chosen directory"

read -p "Do you want to run this script in the directory you are currently in? (y/n): " use_current_directory

if [[ $use_current_directory == "y" ]]; then
	save_directory="$(pwd)"
else

	read -p "Enter the directory to save images in (absolute path (start with ~/)): " save_directory
	eval save_directory=$save_directory
fi

mkdir -p "$save_directory"

if [ ! -d "$save_directory" ]; then
	echo "Error creating directory: $save_directory"
	exit 1
fi

max_num=0

for file in "$save_directory"/*; do
	filename=$(basename "$file")
	num=${filename%%.*}
	if [[ $num =~ ^[0-9]+$ ]] && (( num > max_num )); then
		max_num=$num
	fi
done

counter=$((max_num + 1))

image_urls=()

echo "Enter each URL followed by [ENTER]. Type 'done' when finished:"

while true; do
	read -p "Enter URL (or 'done' if finished): " url
	if [[ $url == "done" ]]; then
		break
	fi
	image_urls+=("$url")
done

for url in "${image_urls[@]}"; do
	file_extension="${url##*.}"
	wget -O "${save_directory}/${counter}.${file_extension}" "$url"
	((counter++))
done

