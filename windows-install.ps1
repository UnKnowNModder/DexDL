param(
    [string]$DistroName
)

$ErrorActionPreference = 'Stop'
$binUrl = 'https://github.com/UnKnowNModder/DexDL/raw/master/dexdl'
$installDirectory = Join-Path $env:LOCALAPPDATA 'DexDL'
$wrapperPath = Join-Path $installDirectory 'dexdl.cmd'

Write-Host 'Checking WSL environment...'
if (-not (Get-Command wsl.exe -ErrorAction SilentlyContinue)) {
    throw 'WSL is required. Install it with: wsl --install, then restart Windows.'
}

if (-not $DistroName) {
    $DistroName = @(wsl.exe --list --quiet 2>$null | ForEach-Object { $_.Trim() } | Where-Object { $_ })[0]
}

if (-not $DistroName) {
    throw 'No WSL distribution was found. Install one with: wsl --install -d Ubuntu'
}

Write-Host "Installing DexDL in WSL distribution '$DistroName'..."
$installCommand = @"
set -e
sudo apt-get update
sudo apt-get install -y ca-certificates wget libjpeg-turbo8 libpng16-16
wget -q '$binUrl' -O /tmp/dexdl
sudo install -m 0755 /tmp/dexdl /usr/local/bin/dexdl
rm -f /tmp/dexdl
"@

& wsl.exe -d $DistroName -- bash -lc $installCommand
if ($LASTEXITCODE -ne 0) {
    throw 'DexDL installation in WSL failed.'
}

New-Item -ItemType Directory -Path $installDirectory -Force | Out-Null
$escapedDistroName = $DistroName.Replace('"', '""')
@"
@echo off
wsl.exe -d "$escapedDistroName" -- dexdl %*
"@ | Set-Content -Path $wrapperPath -Encoding ASCII

$userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
$pathEntries = @($userPath -split ';' | Where-Object { $_ })
if ($pathEntries -notcontains $installDirectory) {
    $newUserPath = (($pathEntries + $installDirectory) -join ';')
    [Environment]::SetEnvironmentVariable('Path', $newUserPath, 'User')
}

Write-Host 'Success! Open a new terminal, then run examples below:'
Write-Host '  dexdl 3bb0279f-a01d-4aa4-93e4-305800f4b83e'
Write-Host '  dexdl https://mangadex.org/title/3bb0279f.../akatsuki-no-yona'