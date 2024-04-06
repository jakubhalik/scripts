#!/bin/bash

max_num=-1
declare -A file_map

read -p "Do you want to run this script in the directory you are currently in? (y/n): " use_current_directory

if [[ $use_current_directory != "y" ]]; then
	read -p "Enter the directory in which you want this script to run in (use absolute path (start with ~/)): " directory_for_script_to_run_in
	cd "${directory_for_script_to_run_in/#\~/$HOME}" || exit
fi	

for file in *.{jpg,png}; do
	if [[ -f "$file" ]]; then
		num=${file%.*}
		extension=${file##*.}

		if ! [[ $num =~ ^[0-9]+$ ]]; then
			echo "File $file does not have a numeric name."
			read -p "Do dou want to delete this file? (y/n): " choice
			case "$choice" in
				y )
					echo "Deleting file $file."
					rm "$file"
					;;
				n )
					echo "Not deleting file $file."
					;;
				* )
					echo "Invalid response. Not deleting file $file."
					;;
			esac
			echo "Highest number file: $max_num"
		fi

		if [[ -n ${file_map[$num]} ]]; then
			file_map[$num]+=" and $file"
			echo "Duplicate number found: $num (Files: ${file_map[$num]})."
			echo "Highest number file: $max_num"
			new_num=$((max_num + 1))
			new_file="$new_num.$extension"
			mv "$file" "$new_file"
			echo "Renamed $file to $new_file due to duplicate."
			file_map[$new_num]=$new_file
			max_num=$new_num
			echo "New highest number file: $max_num"

		else 
			file_map[$num]=$file
		fi

		if (( num > max_num )); then
			max_num=$num
		fi
	fi
done

for ((i=0; i<max_num; i++)); do
	if [[ ! ${file_map[$i]} ]]; then
		echo "Missing file for number $i."
		missing_num=$i
		break
	fi
done

if [[ -n $missing_num ]]; then
	highest_file=${file_map[$max_num]}
	extension=${highest_file##*.}
	new_file="$missing_num.$extension"
	mv "$highest_file" "$new_file"
	echo "Renamed file $highest_file to $new_file to fill missing number."
fi

echo "All checks passed or my action changed everything that you told me to change. Unless you said no to any request where I have you an option all files are correctly sequenced from 0 to $max_num."

