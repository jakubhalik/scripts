#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or use sudo"
  exit
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

for i in {0..10}; do
    if [[ $i -lt 5 || $i -eq 6 || $i -eq 7 ]]; then
        timeout 60 bash -c "${commands_full[$i]}"
    else
        bash -c "${commands_full[$i]}"
    fi
done

for i in {1..11}; do
    echo -e "\n\n--- Output of monitoring${i}.log ---" >> monitoring.log
    tail -n 70 monitoring${i}.log >> monitoring.log
done

