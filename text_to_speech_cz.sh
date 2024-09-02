#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_text_file> <output_audio_file>"
    exit 1
fi

input_file=$1
output_file=$2

if [ ! -f "$input_file" ]; then
    echo "Error: Input file '$input_file' does not exist."
    exit 1
fi

text=$(cat "$input_file")
echo "$text" | text2wave -eval "(voice_czech_ph)" -o "$output_file"

echo "Conversion complete. Audio saved to $output_file"

