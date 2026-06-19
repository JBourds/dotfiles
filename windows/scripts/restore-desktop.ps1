# Restores normal desktop item behavior for the current user.

$ErrorActionPreference = 'Stop'
$path = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer'
if (Test-Path $path) {
  Remove-ItemProperty -Path $path -Name NoDesktop -ErrorAction SilentlyContinue
}

Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
Start-Process explorer.exe
Write-Host 'Desktop items restored.'
