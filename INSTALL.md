# Setup

```bash
sudo -i
parted /dev/nvme0n1 -- mklabel gpt
parted /dev/nvme0n1 -- mkpart root xfs 512MB 100%
parted /dev/nvme0n1 -- mkpart ESP fat32 1MB 512MB
parted /dev/nvme0n1 -- set 2 esp on

mkfs.fat -F 32 /dev/nvme0n1p2 -n "NixOS-Boot"
cryptsetup luksFormat -y --label="NixOS-Encrypted" /dev/nvme0n1p1
cryptsetup luksOpen /dev/nvme0n1p1 cryptroot

pvcreate /dev/mapper/cryptroot
vgcreate lvmroot /dev/mapper/cryptroot

lvcreate --size 128G lvmroot --name swap
lvcreate -l 100%FREE lvmroot --name root

mkfs.xfs -L "NixOS-Root" /dev/mapper/lvmroot-root
mkswap -L "NixOS-Swap" /dev/mapper/lvmroot-swap


mount /dev/disk/by-label/NixOS-Root /mnt
mkdir /mnt/boot

mount /dev/nvme0n1p2 /mnt/boot

swapon /dev/disk/by-label/NixOS-Swap


nixos-generate-config --root /mnt

# Edit NixOS configuration
vim /mnt/etc/nixos/configuration.nix

nixos-install

# To change user password
nixos-enter --root /mnt
passwd username

# Reboot

reboot 
```

Rebuild with `nixos-rebuild switch --flake`
