-- Hyprland Lua config (ported from hyprland.conf)
local theme = require("theme")

-- Display
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

-- Programs
local terminal    = "wezterm"
local fileManager = "nemo"
local menu        = "wofi --show drun"

-- Startup
hl.on("hyprland.start", function()
    hl.exec_cmd(terminal)
    hl.exec_cmd("nm-applet &")
    hl.exec_cmd("firefox")
    hl.exec_cmd("uwsm app")
    hl.exec_cmd("swaync")
    hl.exec_cmd("hyprpolkitagent")
    hl.exec_cmd("systemctl --user enable --now hyprpaper.service")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("systemctl --user start hyprland-session.target")
    hl.exec_cmd("systemctl --user start --now waybar.service")
    hl.exec_cmd("systemctl --user enable --now hypridle.service")
    hl.exec_cmd("systemctl --user enable --now kanshi.service")
    hl.exec_cmd("hyprlock")
end)

-- Environment Variables
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Look and Feel
hl.config({
    general = {
        gaps_in          = 5,
        gaps_out         = 20,
        border_size      = 2,
        col              = {
            active_border   = theme.springBlue,
            inactive_border = theme.fujiGray,
        },
        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding         = 10,
        rounding_power   = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow           = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur             = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = false,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = true,
        enable_anr_dialog       = false,
    },

    input = {
        kb_layout    = "us",
        kb_variant   = "",
        kb_model     = "",
        kb_options   = "",
        kb_rules     = "",

        follow_mouse = 1,
        sensitivity  = 0,

        touchpad     = {
            natural_scroll = false,
        },
    },
})

-- Per-device config
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

-- Keybinds
local mainMod = "ALT"

-- Brightness / media keys
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { repeating = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Screenshots
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind(mainMod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))

-- Programs
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("uwsm stop"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(fileManager))

-- Window focus (vim keys)
local dirs = { h = "left", l = "right", k = "up", j = "down" }

local function focusBinds()
    for key, dir in pairs(dirs) do
        hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = dir }), { repeating = true })
    end
    hl.bind(mainMod .. " + N", hl.dsp.window.cycle_next(), { repeating = true })
end
focusBinds()

-- Workspaces: switch with SUPER + [0-9], move window with SUPER + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- workspace 10 is on key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move workspaces over monitors
hl.bind(mainMod .. " + M", hl.dsp.submap("move_m"))
hl.define_submap("move_m", "reset", function()
    for key, dir in pairs(dirs) do
        hl.bind(key, hl.dsp.workspace.move({ monitor = dir }), { repeating = true })
    end
    hl.bind("CTRL + C", hl.dsp.submap("reset"))
end)

-- Move windows with vim keys (also works within a group and across monitors)
hl.bind(mainMod .. " + S", hl.dsp.submap("move_w"))
hl.define_submap("move_w", "reset", function()
    for key, dir in pairs(dirs) do
        hl.bind(key, hl.dsp.window.move({ direction = dir }), { repeating = true })
    end
    hl.bind("CTRL + C", hl.dsp.submap("reset"))
    -- Generic window control keys
    focusBinds()
    hl.bind(mainMod .. " + K", hl.dsp.window.close())
end)

-- Resize windows with vim keys
hl.bind(mainMod .. " + R", hl.dsp.submap("resize_w"))
hl.define_submap("resize_w", "reset", function()
    hl.bind("L", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
    hl.bind("H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
    hl.bind("K", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
    hl.bind("J", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
    hl.bind("CTRL + C", hl.dsp.submap("reset"))
    -- Generic window control keys
    focusBinds()
    hl.bind(mainMod .. " + K", hl.dsp.window.close())
end)

-- Windows And Workspaces

-- Ignore maximize requests from apps
hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})
