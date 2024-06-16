#!/bin/bash
sudo mkdir ~/filebrowser
cd filebrowser
curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash
echo "
    {
      "port": 8082,
      "address": "0.0.0.0",
      "log": "stdout",
      "database": "/home/x/filebrowser/filebrowser.db",
      "root": "/home/x/filebrowser"
    }
" > config.json
sudo filebrowser -c config.json
