read -p "Install and configure git? [y/n] " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo 'Install git'
    sudo apt install git -y
    echo "Don't forget to configure your git by applying these settings:"
    echo '--------------------------------------------------------------'
    echo 'git config --global user.name "Markus Kofler"'
    echo 'git config --global user.email "git@markuskofler.com"'
    echo 'git config --global core.autocrlf false'
    echo 'git config --global core.editor "code --wait --new-window"'
    echo 'git config --global init.defaultbranch main'
    echo '--------------------------------------------------------------'
    echo '-----------------------------------------------------------------------'
    echo 'git should have been installed and configured'
    echo '-----------------------------------------------------------------------'
else
    echo '[Skipped] Installing and configuring git'
fi
