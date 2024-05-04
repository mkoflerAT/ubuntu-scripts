read -p "Install ProtonVPN? [y/n] " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo 'Installing ProtonVPN...'
    wget https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3_all.deb
    sudo apt-get install ./protonvpn-stable-release_1.0.3_all.deb -y
    sudo apt-get update
    sudo apt-get install protonvpn protonvpn-cli -y
    echo 'Clean-up downloaded packages...'
    rm ./protonvpn-stable-release_1.0.3_all.deb
    echo 'Installing tray-icon for ProtonVPN...'    
    sudo apt install gnome-shell-extension-appindicator gir1.2-appindicator3-0.1 -y
    echo 'ProtonVPN should be now installed in your system. Please restart your machine to see the tray-icon.'
else
    echo '[Skipped] Installing ProtonVPN'
fi
