#!/bin/bash

count_lines() {
	local dir=$1
	find "$dir" -maxdepth 1 -type f -exec cat {} + | wc -l
}

export -f count_lines

while IFS= read -r -d '' dir; do
	count=$(count_lines "$dir")
	formatted_count=$(echo $count | sed ':a;s/\B[0-9]\{3\}\>/ &/;ta')
	echo "$dir: $formatted_count"
	total=$((total + count))
done < <(find . -type d -print0)

formatted_total=$(echo $total | sed ':a;s/\B[0-9]\{3\}\>/ &/;ta')
echo "Total lines in all directories: $formatted_total"

