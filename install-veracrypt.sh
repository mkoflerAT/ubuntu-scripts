read -p "Install VeraCrypt (GUI-version)? [y/n] " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo 'Installing VeraCrypt...'

    # install GUI-version of VeraCrypt
    echo 'Installing VeraCrypt-GUI...'
    wget https://launchpad.net/veracrypt/trunk/1.26.7/+download/veracrypt-1.26.7-Ubuntu-22.04-amd64.deb
    mv ./veracrypt-1.26.7-Ubuntu-22.04-amd64.deb /tmp/
    sudo apt-get install /tmp/veracrypt-1.26.7-Ubuntu-22.04-amd64.deb -y
    rm /tmp/veracrypt-1.26.7-Ubuntu-22.04-amd64.deb

    # install CLI-version of VeraCrypt
    # echo 'Installing VeraCrypt-Console...'
    # wget https://launchpad.net/veracrypt/trunk/1.26.7/+download/veracrypt-console-1.26.7-Ubuntu-22.04-amd64.deb
    # mv ./veracrypt-console-1.26.7-Ubuntu-22.04-amd64.deb /tmp/
    # sudo apt-get install /tmp/veracrypt-console-1.26.7-Ubuntu-22.04-amd64.deb -y
    # rm /tmp/veracrypt-console-1.26.7-Ubuntu-22.04-amd64.deb
    echo 'VeraCrypt should be now installed in your system.'
else
    echo '[Skipped] Installing VeraCrypt'
fi
