#!/bin/bash

read -p "Enter postgres connection info: " postgresDbInfo

psql "$postgresDbInfo" -c "select * from registration_table;" | 
tail -n +3 | 
awk -F '|' '{
	printf "["; 
	for(i=1; i<=NF; i++) {
		gsub(/^[ \t]+|[ \t]+$/, "", $i); 
		printf "\"" $i "\""; 
		if (i<NF) printf ", "; 
	} 
	printf "]\n"; 
}'  | 
xsel --clipboard --input

