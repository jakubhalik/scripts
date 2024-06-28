#!/bin/bash

repo_dir=$1

if [ -z "$repo_dir" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

if [ ! -d "$repo_dir" ]; then
  echo "Error: Directory $repo_dir does not exist."
  exit 1
fi

repos=($(find "$repo_dir" -name ".git" -type d -prune -exec stat -c "%Y %n" {} \; | sort -nr | awk -F'/' '{print $(NF-1)}'))

if [ ${#repos[@]} -eq 0 ]; then
  echo "No repositories found in $repo_dir."
  exit 1
fi

for i in "${!repos[@]}"; do
  echo "$((i + 1)). ${repos[$i]}"
done
