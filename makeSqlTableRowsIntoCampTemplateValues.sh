#!/bin/bash

labels="id,Jméno dítěte,Příjmení dítěte,Datum narození dítěte,Velikost trika dítěte,Ulice a číslo,Město,PSČ,Země,Další informace,Jméno zákonného zástupce,Příjmení zákonného zástupce,Telefonní číslo zákonného zástupce,Email zákonného zástupce,Dotazy/další informace"

read -p "Enter postgres connection info: " postgresDbInfo

echo "Fetching data from postgresql..."

output=$(psql "$postgresDbInfo" -c "select * from registration_table;")

if [ $? -eq 0 ]; then

	echo "Data fetched successfully. Processing..."
	echo "Raw output: "
	echo "$output"

	processed_output=$(
		echo "$output" |
		tail -n +3 | 
		awk -F '|' -v labels="$labels" '{
			num_labels = split(labels, label_array, ",");
			num_fields = split($0, fields, "|");
			print "Number of labels: " num_labels;
			print "Number of fields: " num_fields;
			if(num_fields == num_labels) {
				for(i=1; i<=num_fields; i++) {
					gsub(/^[ \t]+|[ \t]+$/, "", fields[i]);
					printf "%s: %s<br />\n", label_array[i], fields[i];
				}
				printf "\n";
			}
		}'
	)

	echo "Processed output:"
	echo "$processed_output"

	echo "$processed_output" | xsel --clipboard --input
	echo "Data copied to clipboard in the desired template."

else
	echo "Failed to execute psql command."
fi

echo "Script end."

