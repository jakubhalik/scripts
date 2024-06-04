#!/bin/bash
curl "https://api.github.com/users/jakubhalik/repos?per_page=10000" | jq -r '.[].ssh_url' | xargs -L1 git clone
