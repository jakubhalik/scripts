# I used similar script for github twice, writing it here for gitlab is just an experiment prep in advance, I do not know if this will work exactly the same way for gitlab, so when I do actually need to use this for gitlab I will either remove this comment or remove this comment and change the code
#!/bin/bash
curl "https://api.gitlab.com/users/jakubhalik/repos?per_page=10000" | jq -r '.[].ssh_url' | xargs -L1 git clone
