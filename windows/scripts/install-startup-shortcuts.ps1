# Adds GlazeWM and Flow Launcher to the current user's Startup folder.
# Zebar is started by GlazeWM via general.startup_commands in glazewm/config.yaml.

$ErrorActionPreference = 'Stop'
$startup = [Environment]::GetFolderPath('Startup')
$shell = New-Object -ComObject WScript.Shell

function New-StartupShortcutFromCommand {
  param(
    [Parameter(Mandatory=$true)] [string] $CommandName,
    [Parameter(Mandatory=$true)] [string] $ShortcutName,
    [string] $Arguments = ''
  )

  $cmd = Get-Command $CommandName -ErrorAction SilentlyContinue | Select-Object -First 1
  if (-not $cmd) {
    Write-Warning "$CommandName was not found on PATH; skipping $ShortcutName."
    return
  }

  $lnk = Join-Path $startup "$ShortcutName.lnk"
  $shortcut = $shell.CreateShortcut($lnk)
  $shortcut.TargetPath = $cmd.Source
  $shortcut.Arguments = $Arguments
  $shortcut.WorkingDirectory = Split-Path $cmd.Source
  $shortcut.Save()
  Write-Host "Created startup shortcut: $lnk"
}

New-StartupShortcutFromCommand -CommandName 'glazewm.exe' -ShortcutName 'GlazeWM' -Arguments 'start'
New-StartupShortcutFromCommand -CommandName 'Flow.Launcher.exe' -ShortcutName 'Flow Launcher'
