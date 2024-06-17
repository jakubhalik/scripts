#!/bin/bash

# For the case of you poor thing rerunning the script after some mistakes I will run the commands till pinata, if u do not need this comment all until pinata out
docker ps -a --filter "name=mattermost"  # List all Mattermost-related containers
docker stop $(docker ps -a -q --filter "name=mattermost")  # Stop all Mattermost-related containers
docker rm $(docker ps -a -q --filter "name=mattermost")  # Remove all Mattermost-related containers
docker volume ls --filter "name=mattermost"  # List all Mattermost-related volumes
docker volume rm $(docker volume ls -q --filter "name=mattermost")  # Remove all Mattermost-related volumes
docker network ls --filter "name=mattermost"  # List all Mattermost-related networks
docker network rm $(docker network ls -q --filter "name=mattermost")  # Remove all Mattermost-related networks
rm /etc/nginx/sites-available/mattermost.jakubhalik.org
rm /etc/nginx/sites-enabled/mattermost.jakubhalik.org
nginx -t  # Test Nginx configuration to ensure there are no syntax errors
systemctl restart nginx  # Restart Nginx to apply changes
find /home/x/mattermost -type d  # Verify existence of the directory
rm -rf /home/x/mattermost  # Remove the directory
certbot delete --cert-name mattermost.jakubhalik.org
nginx -t
systemctl restart nginx
#pinata

# Ensure script is run with sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or use sudo"
  exit
fi

echo "Right now there is supposed to be no /etc/nginx/sites-available/mattermost.jakubhalik.org file: "
find /etc/nginx/sites-available/mattermost.jakubhalik.org
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
echo "Just created the /etc/nginx/sites-available/mattermost.jakubhalik.org file: "
find /etc/nginx/sites-available/mattermost.jakubhalik.org
cat /etc/nginx/sites-available/mattermost.jakubhalik.org
echo "Right now there is no /etc/nginx/sites-enabled/mattermost.jakubhalik.org: "
find /etc/nginx/sites-enabled/mattermost.jakubhalik.org
echo "Creating a symlink from sites-available to sites-enabled: "
ln -s /etc/nginx/sites-available/mattermost.jakubhalik.org /etc/nginx/sites-enabled/
find /etc/nginx/sites-enabled/mattermost.jakubhalik.org
cat /etc/nginx/sites-enabled/mattermost.jakubhalik.org
echo "Obtaining SSL certificate using certbot: "
certbot --nginx -d mattermost.jakubhalik.org
echo "Changing the mattermost.jakubhalik.org for https: "
rm /etc/nginx/sites-available/mattermost.jakubhalik.org
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
find /etc/nginx/sites-available/mattermost.jakubhalik.org
cat /etc/nginx/sites-available/mattermost.jakubhalik.org
nginx -t
systemctl restart nginx

echo "Right now there is supposed to be no ~/mattermost directory: "
find /home/x/mattermost
mkdir /home/x/mattermost
echo "Just created mattermost directory in the home path: "
find /home/x/mattermost
cd /home/x/mattermost
echo "Right now there is supposed to be no docker directory in here: "
find docker
git clone https://github.com/mattermost/docker
echo "Just cloned mattermost docker from their github: "
find docker
cd docker
echo "Right now there is .gitpod.yml file that I will delete: "
find .gitpod.yml
rm .gitpod.yml
echo "Removed .gitpod.yml as it is not needed for local deployment: "
find .gitpod.yml
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
    POSTGRES_PASSWORD=mmuser_password
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
chown -R 2000:2000 ./volumes/app/mattermost
docker compose -f docker-compose.yml -f docker-compose.without-nginx.yml up -d

