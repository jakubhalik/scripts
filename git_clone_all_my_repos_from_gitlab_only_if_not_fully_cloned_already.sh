#!/bin/bash

read -sp 'Enter your GitLab personal access token: ' access_token
echo

gitlab_url="https://localgitlab.jakubhalik.org"

projects=$(curl --header "PRIVATE-TOKEN: $access_token" "$gitlab_url/api/v4/projects?membership=true&per_page=1000")

project_urls=$(echo $projects | jq -r '.[].http_url_to_repo')

target_dir="/home/x/d/g/gl"

mkdir -p $target_dir

cd $target_dir

failed_urls=()

is_repo_cloned() {
    repo_dir=$1
    if [ -d "$repo_dir/.git" ]; then
        cd "$repo_dir"
        git rev-parse --is-inside-work-tree &> /dev/null
        if [ $? -eq 0 ]; then
            cd - > /dev/null
            return 0
        fi
        cd - > /dev/null
    fi
    return 1
}

clone_repo() {
    url=$1
    repo_name=$(basename -s .git $url)
    repo_dir="$target_dir/$repo_name"
    
    if is_repo_cloned $repo_dir; then
        echo "Repository $repo_name already fully cloned, skipping."
        return 0
    fi
    
    modified_url="${url/https:\/\//https:\/\/$access_token@}"
    echo "Cloning from $modified_url"
    output=$(git clone $modified_url 2>&1)
    if echo "$output" | grep -q "Password for"; then
        return 1
    else
        return 0
    fi
}

for url in $project_urls; do
    clone_repo $url
    if [ $? -ne 0 ]; then
        echo "Failed to clone $url, adding to retry list."
        failed_urls+=($url)
    else
        echo "Successfully cloned $url"
    fi
done

attempts=0
max_attempts=10

while [ ${#failed_urls[@]} -gt 0 ]; do
    ((attempts++))
    echo "Retry attempt $attempts/$max_attempts"
    remaining_urls=()
    for url in "${failed_urls[@]}"; do
        clone_repo $url
        if [ $? -ne 0 ]; then
            echo "Failed to clone $url"
            remaining_urls+=($url)
        else
            echo "Successfully cloned $url"
        fi
    done
    failed_urls=("${remaining_urls[@]}")

    if [ ${#failed_urls[@]} -eq 0 ]; then
        echo "All repositories cloned successfully."
        exit 0
    elif [ $attempts -ge $max_attempts ]; then
        read -p "Do you want to try again 10 more times? (y/n): " choice
        case "$choice" in
            y|Y ) attempts=0 ;;
            n|N ) echo "Exiting script."; exit 1 ;;
            * ) echo "Invalid input. Exiting script."; exit 1 ;;
        esac
    fi
done

echo "Script completed."
