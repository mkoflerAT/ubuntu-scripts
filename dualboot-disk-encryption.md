## dualboot-disk-encryption

This guide creates a dual-boot for Win10 and Linux Mint 21.3 (Virginia) with full disk-encryption  
for both operating systems from scratch. Linux does only support full disk-encryption out of the box,  
if you wipe the entire harddrive, but since dualboot is desired we need to this manually:

First install Win10 without an internet-connection during setup with a local username.  
After you have installed Win10/11 prepare your disk for the dualboot-installation with Linux:

  1. Run 'diskmgmt.msc' and shrink C: to 204802 MB (~200GB) - 2MB were added to prevent showing '199,99GB'  
  2. Fire up a 'cmd' as administrator and within run 'reagentc.exe /disable' to disable the recovery-environment  
  3. Run 'diskpart' and within there partition the disk by using the following commands:
        
    list disk
    list partition
    select partition 4
    delete partition override
    
    create partition primary size=2050
    format quick fs=ntfs label="MINT-BOOT"
    
    create partition primary size=81922
    format quick fs=ntfs label="MINT-ROOT"

    create partition primary size=614402
    format quick fs=ntfs label="DATA"
    
    create partition primary size=4098 id=de94bba4-06d1-4d40-a16a-bfd50179d6ac
    gpt attributes =0x8000000000000001
    format quick fs=ntfs label="WinRE"
    exit

The re-creation/increase of the size of the Windows-Recovery-Partition is necessary to ensure  
that Windows updates are working, due to the fact Microsoft has dimensioned this partition too small.

  4. Run 'reagentc.exe /enable' to enable the recovery-environment again
  5. Now make all Windows-Updates (may take several rounds till everything is installed)
  6. Install VeraCrypt and do an encryption of your OS-partition and encrypt C: fully
  7. After Win10 is fully installed and encrypted by VeraCrypt start Linux-Mint from an USB-drive
  8. Fire up a terminal (CTRL+ALT+T) and run all the following commands:

    setxkbmap de
    sudo fdisk -l
    PBOOT=/dev/nvme0n1p4
    PLUKS=/dev/nvme0n1p5
    sudo mkfs.ext4 $PBOOT
    sudo cryptsetup luksFormat $PLUKS
    sudo cryptsetup luksOpen $PLUKS cryptmk
    sudo dd if=/dev/zero of=/dev/mapper/cryptmk bs=16M
    sudo pvcreate /dev/mapper/cryptmk
    sudo vgcreate vgmk /dev/mapper/cryptmk
    sudo lvcreate -n lvmkswap -L 8G vgmk
    sudo lvcreate -n lvmkroot -l 100%FREE vgmk
    sudo mkfs.ext4 /dev/mapper/vgmk-lvmkroot
    sudo mkswap /dev/mapper/vgmk-lvmkswap

At this point you need install Linux Mint graphically and assign the partitions (custom!).  
Assign filesystem 'ext4' for the boot-partition with mountpoint '/boot' - format-option can be ticked.  
Assign filesystem 'ext4' for the system-partition with mountpoint '/' - format-option can be ticked.  
Assigning the swap-partition shouldn't be necessary because it will automatically recognize it.  

    sudo mount /dev/mapper/vgmk-lvmkroot /mnt/
    sudo mount $PBOOT /mnt/boot/
    sudo mount --bind /dev/ /mnt/dev/
    echo -e "cryptmk UUID=`sudo blkid -o value $PLUKS | head -1` none luks" | sudo tee -a /mnt/etc/crypttab
    sudo chroot /mnt/ mount -t proc proc /proc/
    sudo chroot /mnt/ mount -t sysfs sys /sys/
    sudo chroot /mnt/ mount -t devpts devpts /dev/pts/
    sudo chroot /mnt/ update-initramfs -k all -c

The system should be installed now successfully. Reboot your machine and remove the usb-drive when asked.
Now you should have a fully working dual-boot for Win10/Mint with both systems completely encrypted.
