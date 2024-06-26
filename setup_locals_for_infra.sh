#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or use sudo"
  exit
fi

cd /etc/nginx/sites-available

names=("gitlab" "cloud" "excalidraw" "friends")
port_specifications=("1" "2" "3" "4")

successful=()
failed=()

after_successful_certificates() {
  local name=$1
  local port_specification=$2
  
  rm local${name}.jakubhalik.org
  echo "
  server {
      listen 80;
      listen [::]:80;
      server_name local${name}.jakubhalik.org;

      location / {
          return 301 https://\$host\$request_uri;  # Redirect all HTTP traffic to HTTPS
      }
  }

  server {
      server_name local${name}.jakubhalik.org;

      listen 443 ssl;
      listen [::]:443 ssl;

      ssl_certificate /etc/letsencrypt/live/local${name}.jakubhalik.org/fullchain.pem;
      ssl_certificate_key /etc/letsencrypt/live/local${name}.jakubhalik.org/privkey.pem;

      include /etc/letsencrypt/options-ssl-nginx.conf;
      ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

      location / {
          proxy_pass http://localhost:808${port_specification};
          proxy_set_header Host \$host;
          proxy_set_header X-Real-IP \$remote_addr;
          proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto \$scheme;

          proxy_read_timeout 1d;
          proxy_connect_timeout 1d;
          proxy_send_timeout 1d;
          send_timeout 1d;
      }

      error_page 500 502 503 504 /50x.html;
      location = /50x.html {
          root /usr/share/nginx/html;
      }
  }
  " > local${name}.jakubhalik.org
  ln -s /etc/nginx/sites-available/local${name}.jakubhalik.org /etc/nginx/sites-enabled/
  systemctl restart nginx
  systemctl reload nginx
  echo "Removed old sites files and replaced them with new ones."
}

for i in "${!names[@]}"; do
  name="${names[$i]}"
  port_specification="${port_specifications[$i]}"
  
  echo "
  server {
      listen 80;
      listen [::]:80;
      server_name local${name}.jakubhalik.org;

      location / {
          proxy_pass http://localhost:808${port_specification};
      }
  }
  " > local${name}.jakubhalik.org
  
  ln -s /etc/nginx/sites-available/local${name}.jakubhalik.org /etc/nginx/sites-enabled/
  
  certbot --nginx -d local${name}.jakubhalik.org
  if [ $? -eq 0 ]; then
    successful+=("${name}")
    after_successful_certificates "${name}" "${port_specification}"
  else
    failed+=("${name}")
  fi
done

echo "Successful certificates:"
for name in "${successful[@]}"; do
  echo "  - local${name}.jakubhalik.org"
done

echo "Failed certificates:"
for name in "${failed[@]}"; do
  echo "  - local${name}.jakubhalik.org"
done
