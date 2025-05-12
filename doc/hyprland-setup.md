# Hyprland Setup

Install the following packages:

- hyprland
- egl-wayland
- uwsm
- swaync
- pipewire
- hyprpolkitagent
  - add `exec-once = systemctl --user start hyprpolkitagent` and restart hyprland
  - start with `systemctl --user enable --now hyprpolkitagent.service`
- qt5-wayland
- qt6-wayland
- nvidia
- nvidia-utils
- nvidia-dkms
- xev
  - `sudo pacman -S xorg-xev`
- wev

## NVIDIA Setup

Follow steps [here](https://wiki.hyprland.org/Nvidia/) to get Hyprland working with NVIDIA.

  1. Create and edit /etc/modprobe.d/nvidia.conf, and add this line to the file: `options nvidia_drm modeset=1`
  2. Early KMS will allow the Nvidia modules to load earlier into the boot sequence.
  3. On distros using mkinitcpio, like Arch, you can enable it by editing /etc/mkinitcpio.conf. In the MODULES array add the following module names: `MODULES=(... nvidia nvidia_modeset nvidia_uvm nvidia_drm ...)`
