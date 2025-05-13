# Display Manager

Setup `greetd` with the following commands:

```shell
sudo pacman -S greetd
systemctl enable greetd.service
```

- Edit the `/etc/greetd/config.toml` file's `command` option in the `default_session`
section. For Hyprland:

```
...
[default_session]
command = "Hyprland --config /etc/greetd/hyprland.conf"
...
```

Then create `/etc/greetd/hyprland.conf` as:

`exec-once = qtgreet; hyprctl dispatch exit`
