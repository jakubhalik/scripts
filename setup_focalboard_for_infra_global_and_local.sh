#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or use sudo"
  exit
fi

cd /etc/nginx/sites-available

names=("plan", "planning", "task", "tasks", "board", "boards", "calendar", "calendars", "work", "localplan")

successful=()
failed=()

after_successful_certificates() {
   name=$1
  
  rm ${name}.jakubhalik.org
  echo "
  server {
      listen 80;
      listen [::]:80;
      server_name ${name}.jakubhalik.org;

      location / {
          return 301 https://\$host\$request_uri;  # Redirect all HTTP traffic to HTTPS
      }
  }

  server {
      server_name ${name}.jakubhalik.org;

      listen 443 ssl;
      listen [::]:443 ssl;

      ssl_certificate /etc/letsencrypt/live/${name}.jakubhalik.org/fullchain.pem;
      ssl_certificate_key /etc/letsencrypt/live/${name}.jakubhalik.org/privkey.pem;

      include /etc/letsencrypt/options-ssl-nginx.conf;
      ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

      location / {
          proxy_pass http://host:8086;
          proxy_set_header Host \$host;
          proxy_set_header X-Real-IP \$remote_addr;
          proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto \$scheme;

          proxy_read_timeout 300;
          proxy_connect_timeout 300;
          proxy_send_timeout 300;
          send_timeout 300;
      }

      error_page 500 502 503 504 /50x.html;
      location = /50x.html {
          root /usr/share/nginx/html;
      }
  }
  " > ${name}.jakubhalik.org
  ln -s /etc/nginx/sites-available/${name}.jakubhalik.org /etc/nginx/sites-enabled/
  systemctl restart nginx
  systemctl reload nginx
  echo "Removed old sites files and replaced them with new ones."
}

for i in "${!names[@]}"; do
  name="${names[$i]}"
  
  echo "
  server {
      listen 80;
      listen [::]:80;
      server_name ${name}.jakubhalik.org;

      location / {
          proxy_pass http://host:8086;
      }
  }
  " > ${name}.jakubhalik.org
  
  ln -s /etc/nginx/sites-available/${name}.jakubhalik.org /etc/nginx/sites-enabled/
  
  certbot --nginx -d ${name}.jakubhalik.org
  if [ $? -eq 0 ]; then
    successful+=("${name}")
    after_successful_certificates "${name}"
  else
    failed+=("${name}")
  fi
done

echo "Successful certificates:"
for name in "${successful[@]}"; do
  echo "  - ${name}.jakubhalik.org"
done

echo "Failed certificates:"
for name in "${failed[@]}"; do
  echo "  - ${name}.jakubhalik.org"
done
