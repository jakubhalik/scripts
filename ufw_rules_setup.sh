#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or use sudo"
  exit
fi

install_ufw() {
  if ! command -v ufw &> /dev/null; then
    echo "ufw not found, installing..."
    pacman -S --noconfirm ufw
  else
    echo "ufw is already installed."
  fi
}

setup_ufw_rules() {
  echo "Setting up ufw rules..."

  declare -a RULES=(
    "22"
    "80"
    "443"
    "8080"
    "8081"
    "8082"
    "8083"
    "8443"
    "822"
    "9443"
    "1443"
    "2443"
    "from 10.8.0.0/24"
    "from 10.8.0.0/24 to any port 8081 proto tcp"
    "from 10.8.0.0/24 to any port 8082 proto tcp"
    "from 10.8.0.0/24 to any port 8083 proto tcp"
    "8086/tcp"
  )

  for rule in "${RULES[@]}"; do
    ufw allow $rule
  done

  for rule in "${RULES[@]:0:13}"; do
    ufw allow $rule/tcp
  done

  echo "All rules have been set."
}

enable_ufw() {
  echo "Enabling ufw..."
  ufw enable
}

install_ufw
setup_ufw_rules
enable_ufw

echo "ufw installation and setup complete."

