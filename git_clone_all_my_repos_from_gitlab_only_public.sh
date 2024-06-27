#!/bin/bash

gitlab_url="https://localgitlab.jakubhalik.org"

projects=$(curl "$gitlab_url/api/v4/projects?visibility=public&per_page=1000")

project_urls=$(echo $projects | jq -r '.[].http_url_to_repo')

target_dir="/home/x/d/g/gl"

mkdir -p $target_dir

cd $target_dir

for url in $project_urls; do
    echo "Cloning from $url"
    git clone $url
    if [ $? -ne 0 ]; then
        echo "Failed to clone $url"
    else
        echo "Successfully cloned $url"
    fi
done

echo "Script completed."
