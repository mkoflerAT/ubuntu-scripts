#!/bin/bash
# -----------------------------------------------------------------------------------------------------------------------
# https://brave.com/linux/#release-channel-installation
# -----------------------------------------------------------------------------------------------------------------------

read -p "Install brave-browser? [y/n] " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo 'Installing brave-browser...'
    sudo apt install apt-transport-https curl -y
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install brave-browser -y
    echo 'Press super-key (windows-key) and search for "brave". Then right click it to pin it to panel or desktop.'
else
    echo '[Skipped] Installing brave-browser'
fi
