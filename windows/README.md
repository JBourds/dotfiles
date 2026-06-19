# Windows rice: GlazeWM + Zebar

Ports the JBourds Hyprland/Waybar Kanagawa setup to Windows 11 with GlazeWM + Zebar.

## Install base config

```powershell
winget install -e --id glzr-io.glazewm
winget install -e --id glzr-io.zebar
winget install -e --id wez.wezterm
winget install -e --id Flow-Launcher.Flow-Launcher
winget install -e --id Voidstar.FilePilot

powershell -ExecutionPolicy Bypass -File .\install.ps1
```

Reload GlazeWM:

```text
Alt+Shift+R
```

## Windhawk Mods

- Dark mode context menus
- Taskbar auto-hide fine tuning
- Windows 11 Notification Center Styler

## Corrected launcher behavior

Do not bind `Alt+Space` inside GlazeWM. Flow Launcher should own launcher activation.

Recommended Flow setting:

```text
Flow Launcher -> Settings -> General -> Hotkey -> Alt+Space
```

## Hide desktop items

To eliminate desktop icons/items and leave only the Kanagawa wallpaper/background:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\hide-desktop.ps1
```

Restore:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\restore-desktop.ps1
```

## Start GlazeWM by default

Windows still loads Explorer as the shell. GlazeWM is a tiling window manager running on top of Windows, not a full Explorer shell replacement.

Use startup shortcuts instead:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-startup-shortcuts.ps1
```

Zebar is launched by GlazeWM from `general.startup_commands`.

For the cleanest session, combine startup shortcuts with:

- Windhawk: Taskbar auto-hide fine tuning -> prevent taskbar showing at all
- `scripts/hide-desktop.ps1`
- Flow hotkey bridge above

