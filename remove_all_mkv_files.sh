#!/bin/bash
for file in *.mkv; do
    rm "${file%.mkv}.mkv"
done
