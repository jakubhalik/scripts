#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_text_file> <output_audio_file>"
    exit 1
fi
input_file=$1
output_file=$2
espeak-ng -v cs+f3 -s 100 -f "$input_file" -w "$output_file"
echo "Conversion complete. Audio saved to $output_file"

