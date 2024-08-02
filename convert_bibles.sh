#!/bin/bash

sword_dir="$HOME/.sword"
output_dir="$HOME/b"
mkdir -p "$output_dir"
modules=$(ls "$sword_dir/mods.d" | grep '\.conf$' | sed 's/\.conf$//')

old_testament_books=(
    "Genesis" "Exodus" "Leviticus" "Numbers" "Deuteronomy" "Joshua" "Judges" "Ruth"
    "1Samuel" "2Samuel" "1Kings" "2Kings" "1Chronicles" "2Chronicles" "Ezra" "Nehemiah"
    "Esther" "Job" "Psalms" "Proverbs" "Ecclesiastes" "SongOfSolomon" "Isaiah" "Jeremiah"
    "Lamentations" "Ezekiel" "Daniel" "Hosea" "Joel" "Amos" "Obadiah" "Jonah" "Micah"
    "Nahum" "Habakkuk" "Zephaniah" "Haggai" "Zechariah" "Malachi"
)

new_testament_books=(
    "Matthew" "Mark" "Luke" "John" "Acts" "Romans" "1Corinthians" "2Corinthians"
    "Galatians" "Ephesians" "Philippians" "Colossians" "1Thessalonians" "2Thessalonians"
    "1Timothy" "2Timothy" "Titus" "Philemon" "Hebrews" "James" "1Peter" "2Peter"
    "1John" "2John" "3John" "Jude" "Revelation"
)

echo "Starting conversion process..."

for module in $modules; do
    output_file="$output_dir/$module.txt"
    echo "Converting $module to plaintext..."

    for book in "${old_testament_books[@]}" "${new_testament_books[@]}"; do
        for chapter in {1..150}; do
            output=$(diatheke -b "$module" -k "$book $chapter")
            if [[ $output != "Chapter"* ]]; then
                break
            fi
            echo "$output" >> "$output_file"
        done
    done

    if [ -s "$output_file" ]; then
        echo "$module has been successfully converted."
    else
        echo "No text found for $module, file not created." >&2
        rm "$output_file"
    fi
done

echo "Conversion process completed."
echo "All Bibles are converted to plaintext. You can find them in $output_dir"

