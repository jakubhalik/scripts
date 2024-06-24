#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or use sudo"
  exit
fi

if ! command -v pv &> /dev/null; then
    echo "pv could not be found, installing..."
    sudo pacman -Syu --noconfirm pv
fi

mkdir -p /home/x/monitoring
cd /home/x/monitoring

rm -f monitoring{1..11}.log
rm monitoring.log

touch monitoring.log

commands=(
    'htop'
    'top'
    'iostat -x 1'
    'vmstat 1'
    'sar -u 1'
    'netstat -tuln'
    'sudo iftop'
    'sudo nload'
    'free -h'
    'vmstat 1 5'
    'ps aux --sort=-%mem | head -n 10'
)

commands_full=()
for i in {0..10}; do
    commands_full[i]="${commands[$i]} | tee monitoring$(($i + 1)).log"
done

total_commands=${#commands_full[@]}
current_command=0

update_progress() {
    current_command=$((current_command + 1))
    echo -ne "Progress: [$current_command/$total_commands] \r" | pv -pt -e -s $total_commands > /dev/null
}

trap 'echo -e "\nScript interrupted. Cleaning up..."; kill $(jobs -p); exit' SIGINT

for i in {0..10}; do
    if [[ $i -lt 5 || $i -eq 6 || $i -eq 7 ]]; then
        timeout 60 bash -c "${commands_full[$i]}"
    else
        bash -c "${commands_full[$i]}"
    fi
    wait $!
    update_progress
done

for i in {1..11}; do
    echo -e "\n\n--- Output of monitoring${i}.log ---" >> monitoring.log
    tail -n 70 monitoring${i}.log >> monitoring.log
done

echo -ne "Progress: [$current_command/$total_commands] \r" | pv -pt -e -s $total_commands > /dev/null

