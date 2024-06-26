#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or use sudo"
  exit
fi

add_rule() {
  chain=$1
  target=$2
  protocol=$3
  source=$4
  destination=$5
  extra=$6
  iptables -A $chain -p $protocol -s $source -d $destination $extra -j $target
}

chains=("INPUT" "FORWARD" "OUTPUT")
ufw_chains=(
  "ufw-before-logging-input"
  "ufw-before-input"
  "ufw-after-input"
  "ufw-after-logging-input"
  "ufw-reject-input"
  "ufw-track-input"
  "ufw-before-logging-forward"
  "ufw-before-forward"
  "ufw-after-forward"
  "ufw-after-logging-forward"
  "ufw-reject-forward"
  "ufw-track-forward"
  "ufw-before-logging-output"
  "ufw-before-output"
  "ufw-after-output"
  "ufw-after-logging-output"
  "ufw-reject-output"
  "ufw-track-output"
)

for chain in "${chains[@]}"; do
  for ufw_chain in "${ufw_chains[@]}"; do
    if [[ $ufw_chain == *input* && $chain == "INPUT" ]] ||
       [[ $ufw_chain == *forward* && $chain == "FORWARD" ]] ||
       [[ $ufw_chain == *output* && $chain == "OUTPUT" ]]; then
      iptables -A $chain -j $ufw_chain
    fi
  done
done

ports=("tproxy" "8082" "8083" "http" "https" "8086")
for port in "${ports[@]}"; do
  add_rule "INPUT" "ACCEPT" "tcp" "anywhere" "anywhere" "--dport $port"
done

networks=("anywhere" "10.8.0.0/24")
for network in "${networks[@]}"; do
  add_rule "INPUT" "ACCEPT" "all" "$network" "anywhere" ""
  for port in "${ports[@]}"; do
    add_rule "INPUT" "ACCEPT" "tcp" "$network" "anywhere" "--dport $port"
  done
done

add_rule "FORWARD" "ACCEPT" "all" "anywhere" "anywhere" "-m state --state RELATED,ESTABLISHED"
add_rule "FORWARD" "ACCEPT" "all" "10.8.0.0/24" "anywhere" ""
add_rule "FORWARD" "ACCEPT" "all" "anywhere" "10.8.0.0/24" ""

iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

echo "Iptables rules successfully applied."

