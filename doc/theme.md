# Theme

```shell
# Install necessary packages
sudo pacman -S gtk4 gtk-engine-murrine ttf-jetbrains-mono-nerd

# Clone kanagawa theme repo
git clone https://github.com/Fausto-Korpsvart/Kanagawa-GKT-Theme.git

# In the repo, run the install script (only need the dark script)
./install.sh -c dark

# Set the GTK settings to use the theme
gsettings set org.gnome.desktop.interface gtk-theme Kanagawa-Dark
```
