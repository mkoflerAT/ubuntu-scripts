read -p "Configure network-shares? [y/n] " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo 'Configure network-shares...'

    # create a credentials-file to mount the cifs-shares and secure the file
    echo 'Creating a credentials-file: /root/.cifs'
    echo 'username=xxxxxxxxxxxxxxxx'    | sudo tee -a /root/.cifs
    echo 'password=xxxxxxxxxxxxxxxx'    | sudo tee -a /root/.cifs
    sudo chown root.root /root/.cifs
    sudo chmod 600 /root/.cifs

    # create the mount-points for the cifs-shares
    
    # create the mount-point (within the home of the user) - don't run this as root!
    echo 'Creating mount-points for the network-shares.'
    mkdir -p ~/NAS/home-mkoflerAT/                            
    mkdir -p ~/NAS/home-ldaine    
    mkdir -p ~/NAS/software   

    # append necessary entries to permanently mount the shares via fstab
    echo '//192.168.1.100/homes/ldaine      /home/mkoflerat/NAS/home-ldaine         cifs uid=1000,credentials=/root/.cifs,iocharset=utf8 0 0' | sudo tee -a /etc/fstab
    echo '//192.168.1.100/homes/mkoflerAT   /home/mkoflerat/NAS/home-mkoflerAT      cifs uid=1000,credentials=/root/.cifs,iocharset=utf8 0 0' | sudo tee -a /etc/fstab
    echo '//192.168.1.100/software          /home/mkoflerat/NAS/software            cifs uid=1000,credentials=/root/.cifs,iocharset=utf8 0 0' | sudo tee -a /etc/fstab
  
    echo 'Network-shares should have been configured at your system.'
    echo 'Update username and password within the file /root/.cifs by running:'
    echo '-----------------------------------------------------------------------'
    echo 'sudo nano /root/.cifs'
    echo '-----------------------------------------------------------------------'
    echo 'After you have saved the credentials file, mount the shares by running:'
    echo '-----------------------------------------------------------------------'
    echo 'sudo mount -a'
    echo '-----------------------------------------------------------------------'
    echo 'Now for all shares icon should appear on your desktop.'
    echo '-----------------------------------------------------------------------'
else
    echo '[Skipped] Configure network-shares'
fi
