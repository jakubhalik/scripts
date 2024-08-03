#!/bin/dash

get_password() {
    echo "Enter your password: "
    stty -echo
    read password
    stty echo
    echo ""
}

update_system() {
    echo "$password" | sudo -S pacman -Syu --noconfirm
    echo "$password" | yay -Syu --noconfirm
}

get_password

while true; do
    update_system
    sleep 86400
done
