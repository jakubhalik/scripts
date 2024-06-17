#!/bin/bash

# Ensure script is run with sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or use sudo"
  exit 1
fi

# Function to stop and remove Docker containers, volumes, and networks
clean_docker() {
  echo "Stopping and removing Docker containers, volumes, and networks..."
  CONTAINERS=$(docker ps -a -q --filter "name=mattermost")
  if [ -n "$CONTAINERS" ]; then
    docker stop $CONTAINERS || true
    docker rm $CONTAINERS || true
  fi

  VOLUMES=$(docker volume ls -q --filter "name=mattermost")
  if [ -n "$VOLUMES" ]; then
    docker volume rm $VOLUMES || true
  fi

  NETWORKS=$(docker network ls -q --filter "name=mattermost")
  if [ -n "$NETWORKS" ]; then
    docker network rm $NETWORKS || true
  fi

CONTAINERS=$(docker ps -a -q --filter "name=messenger")
  if [ -n "$CONTAINERS" ]; then
    docker stop $CONTAINERS || true
    docker rm $CONTAINERS || true
  fi

  VOLUMES=$(docker volume ls -q --filter "name=messenger")
  if [ -n "$VOLUMES" ]; then
    docker volume rm $VOLUMES || true
  fi

  NETWORKS=$(docker network ls -q --filter "name=messenger")
  if [ -n "$NETWORKS" ]; then
    docker network rm $NETWORKS || true
  fi
}


# Function to remove Nginx configurations
clean_nginx() {
  echo "Stopping Nginx..."
  systemctl stop nginx || true
  
  echo "Removing Nginx configurations..."
  rm -f /etc/nginx/sites-available/messenger.jakubhalik.org
  rm -f /etc/nginx/sites-enabled/messenger.jakubhalik.org
  rm -f /etc/nginx/sites-available/mattermost.jakubhalik.org
  rm -f /etc/nginx/sites-enabled/mattermost.jakubhalik.org

  echo "Killing any process using ports 80 and 443..."
  fuser -k 80/tcp || true
  fuser -k 443/tcp || true
  fuser -k 8084/tcp || true
  fuser -k 1443/tcp || true
  fuser -k 2443/tcp || true

  if nginx -t; then
    systemctl restart nginx || true
  else
    echo "Nginx configuration is invalid. Continuing without restart."
  fi
}

# Function to remove Certbot certificates
clean_certbot() {
  echo "Removing Certbot certificates..."
  certbot delete --cert-name messenger.jakubhalik.org --non-interactive || true
  certbot delete --cert-name mattermost.jakubhalik.org --non-interactive || true
}

# Function to remove residual files
clean_files() {
  echo "Removing residual files..."
  rm -rf /home/x/mattermost
}

# Perform cleanup
clean_docker
clean_nginx
clean_certbot
clean_files

