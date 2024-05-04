#!/bin/bash
# -----------------------------------------------------------------------------------------------------------------------
# https://code.visualstudio.com/docs/setup/linux
# -----------------------------------------------------------------------------------------------------------------------

read -p "Install vscode? [y/n] " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo 'Install vscode'
    wget https://vscode.download.prss.microsoft.com/dbazure/download/stable/e170252f762678dec6ca2cc69aba1570769a5d39/code_1.88.1-1712771838_amd64.deb
    mv ./code_1.88.1-1712771838_amd64.deb /tmp/
    sudo apt install /tmp/code_1.88.1-1712771838_amd64.deb
    rm /tmp/code_1.88.1-1712771838_amd64.deb
    echo '-----------------------------------------------------------------------'
    echo 'vscode should have been installed'
    echo '-----------------------------------------------------------------------'
else
    echo '[Skipped] Installing vscode'
fi
