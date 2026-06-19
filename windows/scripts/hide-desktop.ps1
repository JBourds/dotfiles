# Hides and disables desktop items for the current user, leaving only the wallpaper/background.
# Reversible with restore-desktop.ps1.

$ErrorActionPreference = 'Stop'
$path = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer'
New-Item -Path $path -Force | Out-Null
New-ItemProperty -Path $path -Name NoDesktop -PropertyType DWord -Value 1 -Force | Out-Null

Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
Start-Process explorer.exe
Write-Host 'Desktop items hidden. Use restore-desktop.ps1 to undo.'
