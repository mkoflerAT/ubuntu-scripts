read -p "Install Steam? [y/n] " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo 'Installing Steam...'
    wget https://cdn.akamai.steamstatic.com/client/installer/steam.deb
    mv ./steam.deb /tmp/
    sudo apt-get install /tmp/steam.deb -y
    rm /tmp/steam.deb
    echo 'Steam should be now installed in your system.'
else
    echo '[Skipped] Installing Steam'
fi
