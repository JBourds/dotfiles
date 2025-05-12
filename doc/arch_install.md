# Arch Install Instructions

Some notes for myself when I eventually need to do this again. TLDR: Follow the install guide but use a more complicated partition layout so I can install other kernels in as I so please.

1. Install Arch Linux to an ISO bootable USB drive.
   - Download and verify [here](https://archlinux.org/download/)
   - Write to installation media (I found `dd` command worked nicely) using instructions [here](https://wiki.archlinux.org/title/USB_flash_installation_medium)
2. Disable secure boot on the target device through UEFI.
3. Setup partitions as laid out below:

  - /dev/nvme0n1 (main SSD)
    - nvme0n1p1 (1GB, ESP)
      - Change partition type to `EFI System` using `fdisk t`
    - nvme0n1p2 (5GB, Swap Memory)
      - Change partition type to `Linux LVM`
    - nvme0n1p3 (320GB)
      - arch (80GB Volume Group)
        - root (30GB Logical Volume - Root FS with OS image)
        - home (50GB Logical Volume - Home FS with OS-specific packages)
    - nvme0n1p4 (600GB, Shared Data Directory - Gets symlinked into home)

  This paritition layout allows for the absolute necessities to boot (ESP partition, bootable OS image, root fs) as well as some room to grow in case I want to add additional operating systems. 

Notes on this step:

Partition steps:

1. Make physical partition (`fdisk`)
  - Change partition type using the `t` command in `fdisk`. ESP should be EFI type (1) and root/shared data partitions should be LVM type (44)).
  - This is a GPT (GUID Parition Table) and so every parition is "primary" and bootable. No need to make special paritions for OS images.
2. Create volume group (`vgcreate`)
3. Create logical volume (`lvcreate`)
- `modprobe dm_mod` is used to map devices created with LVM to the file system
4. Setup boot loader using [systemd-boot](https://wiki.archlinux.org/title/Systemd-boot)
- Add UEFI entry for `systemd-boot` 

4. Follow install instructions (wifi, bootstrap pacman, etc)

pacstrap installs:

- linux
- linux-firmware
- linux-firmware-marvell
- lvm2 (add this to mkinitcpio.conf hooks)
    - Need this since we use logical volumes for root FS


5. Setup WiFi:

With WPA Supplicant:

  - wpa_passphrase <SSID> <PASSWORD> | sudo tee /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
  - wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
  - systemctl enable wpa_supplicant@wlan0.service
  - systemctl start wpa_supplicant@wlan0.service
  - sudo chmod 600 /etc/wpa_supplicant/wpa_supplicant-wlan0.conf


3. Add my user: `useradd -m -g users -G wheel jordan` + `passwd jordan`
  - Uncomment the `%wheel...` line in the file which appears when running `visudo`
4. Update root password: `passwd`
 

