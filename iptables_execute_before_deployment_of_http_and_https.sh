#!/bash/bin

sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 8081 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 8082 -j ACCEPT
sudo iptables-save | sudo tee /etc/iptables/iptables.rules > /dev/null
sudo systemctl enable iptables
sudo systemctl start iptables
sudo iptables -L
