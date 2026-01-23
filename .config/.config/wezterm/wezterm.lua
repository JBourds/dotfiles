local wezterm = require("wezterm")
local config = wezterm.config_builder()

return {
    term = "wezterm",
    enable_wayland = false,
    warn_about_missing_glyphs = false,
    color_scheme = 'Kanagawa (Gogh)',
}
