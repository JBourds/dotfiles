# Maintenance

## Timeshift (File System Snapshots)

```shell
sudo pacman -S timeshift
systemctl enable --now cronie.service
```

## Pacman

Cleaning the package cache

```shell
sudo pacman -S pacman-contrib
systemctl enable --now paccache.timer
systemctl start --now paccache.timer
```
