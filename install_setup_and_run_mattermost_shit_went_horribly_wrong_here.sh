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


# Ensure Nginx is correctly configured before proceeding
echo "Creating Nginx configuration for HTTP redirection..."
echo "
    server {
        listen 80;
        listen [::]:80;
        server_name mattermost.jakubhalik.org;

        location / {
            return 301 https://\$host\$request_uri;  # Redirect all HTTP traffic to HTTPS
        }
    }
" > /etc/nginx/sites-available/mattermost.jakubhalik.org

echo "Creating a symlink from sites-available to sites-enabled..."
ln -s /etc/nginx/sites-available/mattermost.jakubhalik.org /etc/nginx/sites-enabled/

echo "Testing Nginx configuration..."
if nginx -t; then
  echo "Restarting Nginx..."
  systemctl restart nginx || true
else
  echo "Nginx configuration is invalid. Exiting..."
  exit 1
fi


# Generate self-signed SSL certificate
echo "Generating self-signed SSL certificate..."
mkdir -p /etc/letsencrypt/live/mattermost.jakubhalik.org
openssl req -newkey rsa:2048 -nodes -keyout /etc/letsencrypt/live/mattermost.jakubhalik.org/privkey.pem -x509 -days 365 -out /etc/letsencrypt/live/mattermost.jakubhalik.org/fullchain.pem -subj "/CN=mattermost.jakubhalik.org"


echo "Testing Nginx configuration..."
if nginx -t; then
  echo "Restarting Nginx..."
  systemctl restart nginx || true
else
  echo "Nginx configuration is invalid. Exiting..."
  exit 1
fi

# Ensure Nginx is correctly configured for HTTPS before proceeding
echo "Changing the Nginx configuration for HTTPS..."
echo "
    server {
        listen 80;
        listen [::]:80;
        server_name mattermost.jakubhalik.org;

        location / {
            return 301 https://\$host\$request_uri;  # Redirect all HTTP traffic to HTTPS
        }
    }

    server {
        server_name mattermost.jakubhalik.org;

        listen 443 ssl;
        listen [::]:443 ssl;

        ssl_certificate /etc/letsencrypt/live/mattermost.jakubhalik.org/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/mattermost.jakubhalik.org/privkey.pem;

        include /etc/letsencrypt/options-ssl-nginx.conf;
        ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

        location / {
            proxy_pass http://localhost:8084;
            proxy_set_header Host \$host;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto \$scheme;
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
            root /usr/share/nginx/html;
         }
    }
" > /etc/nginx/sites-available/mattermost.jakubhalik.org

echo "Testing Nginx configuration again..."
if nginx -t; then
  echo "Restarting Nginx again..."
  systemctl restart nginx || true
else
  echo "Nginx configuration is invalid. Exiting..."
  exit 1
fi

echo "Setting up Mattermost directories..."
mkdir -p /home/x/mattermost
cd /home/x/mattermost

# If the 'docker' directory already exists, remove it to start fresh
if [ -d "docker" ]; then
  rm -rf docker
fi

echo "Cloning Mattermost Docker repository..."
git clone https://github.com/mattermost/docker
cd docker

echo "Removing unnecessary .gitpod.yml file..."
if [ -f ".gitpod.yml" ]; then
  rm .gitpod.yml
fi
echo "Creating environment configuration..."
echo "
    # Domain of service
    DOMAIN=mattermost.jakubhalik.org

    # Container settings
    ## Timezone inside the containers. The value needs to be in the form 'Europe/Berlin'.
    ## A list of these tz database names can be looked up at Wikipedia
    ## https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
    TZ=UTC
    RESTART_POLICY=unless-stopped

    # Postgres settings
    ## Documentation for this image and available settings can be found on hub.docker.com
    ## https://hub.docker.com/_/postgres
    ## Please keep in mind this will create a superuser and it's recommended to use a less privileged
    ## user to connect to the database.
    ## A guide on how to change the database user to a nonsuperuser can be found in docs/creation-of-nonsuperuser.md
    POSTGRES_IMAGE_TAG=13-alpine
    POSTGRES_DATA_PATH=./volumes/db/var/lib/postgresql/data

    POSTGRES_USER=mmuser
    POSTGRES_PASSWORD=a5m6c9c9
    POSTGRES_DB=mattermost

    # Nginx
    ## The nginx container will use a configuration found at the NGINX_MATTERMOST_CONFIG. The config aims
    ## to be secure and uses a catch-all server vhost which will work out-of-the-box. For additional settings
    ## or changes ones can edit it or provide another config. Important note: inside the container, nginx sources
    ## every config file inside */etc/nginx/conf.d* ending with a *.conf* file extension.

    ## Inside the container the uid and gid is 101. The folder owner can be set with
    ## `sudo chown -R 101:101 ./nginx` if needed.
    NGINX_IMAGE_TAG=alpine

    ## The folder containing server blocks and any additional config to nginx.conf
    NGINX_CONFIG_PATH=./nginx/conf.d
    NGINX_DHPARAMS_FILE=./nginx/dhparams4096.pem

    CERT_PATH=./volumes/web/cert/cert.pem
    KEY_PATH=./volumes/web/cert/key-no-password.pem
    #GITLAB_PKI_CHAIN_PATH=<path_to_your_gitlab_pki>/pki_chain.pem
    #CERT_PATH=./certs/etc/letsencrypt/live/\${DOMAIN}/fullchain.pem
    #KEY_PATH=./certs/etc/letsencrypt/live/\${DOMAIN}/privkey.pem

    ## Exposed ports to the host. Inside the container 80, 443 and 8443 will be used
    HTTPS_PORT=1443
    HTTP_PORT=8084
    CALLS_PORT=2443

    # Mattermost settings
    ## Inside the container the uid and gid is 2000. The folder owner can be set with
    ## `sudo chown -R 2000:2000 ./volumes/app/mattermost`.
    MATTERMOST_CONFIG_PATH=./volumes/app/mattermost/config
    MATTERMOST_DATA_PATH=./volumes/app/mattermost/data
    MATTERMOST_LOGS_PATH=./volumes/app/mattermost/logs
    MATTERMOST_PLUGINS_PATH=./volumes/app/mattermost/plugins
    MATTERMOST_CLIENT_PLUGINS_PATH=./volumes/app/mattermost/client/plugins
    MATTERMOST_BLEVE_INDEXES_PATH=./volumes/app/mattermost/bleve-indexes

    ## Bleve index (inside the container)
    MM_BLEVESETTINGS_INDEXDIR=/mattermost/bleve-indexes

    ## This will be 'mattermost-enterprise-edition' or 'mattermost-team-edition' based on the version of Mattermost you're installing.
    MATTERMOST_IMAGE=mattermost-enterprise-edition
    ## Update the image tag if you want to upgrade your Mattermost version. You may also upgrade to the latest one. The example is based on the latest Mattermost ESR version.
    MATTERMOST_IMAGE_TAG=8.1.9

    ## Make Mattermost container readonly. This interferes with the regeneration of root.html inside the container. Only use
    ## it if you know what you're doing.
    ## See https://github.com/mattermost/docker/issues/18
    MATTERMOST_CONTAINER_READONLY=false

    ## The app port is only relevant for using Mattermost without the nginx container as reverse proxy. This is not meant
    ## to be used with the internal HTTP server exposed but rather in case one wants to host several services on one host
    ## or for using it behind another existing reverse proxy.
    APP_PORT=8065

    ## Configuration settings for Mattermost. Documentation on the variables and the settings itself can be found at
    ## https://docs.mattermost.com/administration/config-settings.html
    ## Keep in mind that variables set here will take precedence over the same setting in config.json. This includes
    ## the system console as well and settings set with env variables will be greyed out.

    ## Below one can find necessary settings to spin up the Mattermost container
    MM_SQLSETTINGS_DRIVERNAME=postgres
    MM_SQLSETTINGS_DATASOURCE=postgres://\${POSTGRES_USER}:\${POSTGRES_PASSWORD}@postgres:5432/\${POSTGRES_DB}?sslmode=disable&connect_timeout=10

    ## Example settings (any additional setting added here also needs to be introduced in the docker-compose.yml)
    MM_SERVICESETTINGS_SITEURL=https://\${DOMAIN}
" > .env

mkdir -p ./volumes/app/mattermost/{config,data,logs,plugins,client/plugins,bleve-indexes}
mkdir -p ./nginx
chown -R 2000:2000 ./volumes/app/mattermost

echo "Starting Mattermost Docker containers..."
docker compose -f docker-compose.yml -f docker-compose.without-nginx.yml up -d

