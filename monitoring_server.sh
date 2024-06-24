#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or use sudo"
  exit
fi

echo "Starting script."

mkdir -p /home/x/monitoring
cd /home/x/monitoring

echo "Removing old log files."
rm -f monitoring{1..11}.log
rm -f monitoring.log

touch monitoring.log
echo "Created new monitoring.log file."

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
instant_commands_count=$total_commands
timeout_commands_count=0

# Determine which commands are run with a 60-second timeout
for i in {0..10}; do
    if [[ $i -lt 5 || $i -eq 6 || $i -eq 7 ]]; then
        timeout_commands_count=$((timeout_commands_count + 1))
        instant_commands_count=$((instant_commands_count - 1))
    fi
done

# Estimate total time: 60 seconds for some commands, 5 seconds for others
estimated_total_time=$((timeout_commands_count * 60 + instant_commands_count * 5))

current_command=0
start_time=$(date +%s)

# Initialize the progress bar
echo "Initializing progress bar."
echo -ne "Progress: [0/$total_commands] - Estimated time remaining: $estimated_total_time seconds - Running time: 0 seconds\r"

update_progress() {
    elapsed_time=$(( $(date +%s) - $start_time ))
    estimated_remaining_time=$(( estimated_total_time - elapsed_time ))
    echo -ne "\rProgress: [$current_command/$total_commands] - Estimated time remaining: $estimated_remaining_time seconds - Running time: $elapsed_time seconds\r"
}

trap 'echo -e "\nScript interrupted. Cleaning up..."; kill $(jobs -p); exit' SIGINT

# Function to run a command and continuously print the progress bar
run_command() {
    local command="$1"
    local timeout_value="$2"
    echo "Running command: $command with timeout $timeout_value seconds"
    command_start_time=$(date +%s)
    timeout "$timeout_value" bash -c "$command" | while IFS= read -r line; do
        echo -e "$line"
        update_progress
    done
    wait $!
    command_end_time=$(date +%s)
    echo "Finished command: $command. Duration: $((command_end_time - command_start_time)) seconds."
}

# Background process to update the running time every second
(
    while true; do
        sleep 1
        update_progress
    done
) &

for i in {0..10}; do
    current_command=$((current_command + 1))
    update_progress
    if [[ $i -lt 5 || $i -eq 6 || $i -eq 7 ]]; then
        run_command "timeout 60 ${commands_full[$i]}" 60
    else
        run_command "${commands_full[$i]}" 5
    fi
done

for i in {1..11}; do
    echo "Processing log file: monitoring${i}.log"
    echo -e "\n\n--- Output of monitoring${i}.log ---" >> monitoring.log
    tail -n 70 monitoring${i}.log >> monitoring.log
    echo "Processed log file: monitoring${i}.log"
    # Print the progress bar again to ensure it's visible at the bottom
    update_progress
done

# Final progress update
update_progress
echo -ne "\rProgress: [$current_command/$total_commands] - Completed\n"

echo -e "\nAll commands have been executed and logs are consolidated."
echo "Script finished."

