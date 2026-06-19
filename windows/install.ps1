$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$GlzrRoot = Join-Path $env:USERPROFILE ".glzr"
$GlazeDir = Join-Path $GlzrRoot "glazewm"
$ZebarDir = Join-Path $GlzrRoot "zebar"
$PackName = "jbourds-kanagawa"
$Stamp = Get-Date -Format "yyyyMMdd-HHmmss"

New-Item -ItemType Directory -Force -Path $GlazeDir, $ZebarDir | Out-Null

$GlazeConfig = Join-Path $GlazeDir "config.yaml"
if (Test-Path $GlazeConfig) {
  Copy-Item $GlazeConfig "$GlazeConfig.backup-$Stamp" -Force
}
Copy-Item (Join-Path $Root "glazewm\config.yaml") $GlazeConfig -Force

$Settings = Join-Path $ZebarDir "settings.json"
if (Test-Path $Settings) {
  Copy-Item $Settings "$Settings.backup-$Stamp" -Force
}
Copy-Item (Join-Path $Root "zebar\settings.json") $Settings -Force

$PackSrc = Join-Path $Root "zebar\$PackName"
$PackDst = Join-Path $ZebarDir $PackName
if (Test-Path $PackDst) {
  Rename-Item $PackDst "$PackName.backup-$Stamp"
}
Copy-Item $PackSrc $PackDst -Recurse -Force

Write-Host "Installed JBourds Kanagawa GlazeWM + Zebar config."
Write-Host "GlazeWM config: $GlazeConfig"
Write-Host "Zebar pack:      $PackDst"
Write-Host "Reload GlazeWM with Alt+Shift+R, or restart GlazeWM/Zebar."
Write-Host "Optional extras: scripts\install-flow-hotkeys.ps1, scripts\hide-desktop.ps1, scripts\install-startup-shortcuts.ps1"
