# Wezterm

My current setup configures Wezterm with Hyprland. By default, Hyprland
will use kitty but with a small adjustment wezterm can be used instead.

Install the package: `sudo pacman -S wezterm`

In `~/.config/wezterm/wezterm.lua` make sure the following is included.
It is essential that wayland is not enabled:

```lua
require("wezterm")
local config = {}
config.enable_wayland = false

return config
```
