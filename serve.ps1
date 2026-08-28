# Launch the Jekyll dev server.
#
# Prefers the Windows Ruby install, falls back to WSL. Pass -Wsl to force WSL.
# livereload + force_polling are configured in _config.yml, so no extra flags.
#
# Usage (from this folder):  .\serve.ps1  [-Wsl]
#   or:  powershell -ExecutionPolicy Bypass -File .\serve.ps1

[CmdletBinding()]
param([switch]$Wsl)

$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot

function Initialize-WindowsRuby {
    # Put a Ruby install on PATH if `bundle` isn't already there.
    if (Get-Command bundle -ErrorAction SilentlyContinue) { return $true }
    $bin = Get-ChildItem 'C:\Ruby*\bin\bundle.bat' -ErrorAction SilentlyContinue |
           Select-Object -First 1
    if (-not $bin) { return $false }
    $env:PATH = (Split-Path $bin.FullName) + ';' + $env:PATH
    return $true
}

function Test-WindowsJekyll {
    if (-not (Initialize-WindowsRuby)) { return $false }
    bundle exec jekyll --version *> $null
    return ($LASTEXITCODE -eq 0)
}

function Get-WslPath {
    # wsl.exe eats backslashes in arguments, so hand wslpath forward slashes;
    # -e also skips that parsing. Belt and braces, because a bad path here
    # returns empty and the next call fails with a confusing null error.
    $win = $PSScriptRoot -replace '\\','/'
    $out = (wsl -e wslpath -a "$win" 2>$null | Out-String).Trim()
    return $out
}

function Test-WslJekyll {
    if (-not (Get-Command wsl.exe -ErrorAction SilentlyContinue)) { return $false }
    # WSL inherits the Windows PATH, so `bundle` there often resolves to the
    # Windows executable under /mnt/c, which cannot run the Linux build.
    $found = (wsl -e bash -lc 'command -v bundle' 2>$null | Out-String).Trim()
    if (-not $found) { return $false }
    return (-not $found.StartsWith('/mnt/'))
}

Write-Host '  http://127.0.0.1:4000' -ForegroundColor Cyan

if (-not $Wsl -and (Test-WindowsJekyll)) {
    Write-Host 'Serving with the Windows Ruby (Ctrl+C to stop)...' -ForegroundColor Cyan
    bundle exec jekyll serve --livereload
    exit $LASTEXITCODE
}

if (Test-WslJekyll) {
    $linuxPath = Get-WslPath
    if (-not $linuxPath) { throw "wslpath could not map $PSScriptRoot. Is WSL running? (wsl -l -v)" }
    Write-Host "Serving from WSL at $linuxPath (Ctrl+C to stop)..." -ForegroundColor Cyan
    # -l : login shell so rbenv/gem PATH + `bundle config path` are loaded
    wsl -e bash -lc "cd '$linuxPath' && bundle exec jekyll serve --livereload"
    exit $LASTEXITCODE
}

if ($Wsl) {
    throw 'WSL has no Linux Jekyll. Install one, e.g.:' + [Environment]::NewLine +
          "  wsl -e bash -lc 'sudo apt update && sudo apt install -y ruby-full build-essential zlib1g-dev && gem install --user-install bundler jekyll'"
}

throw 'No Jekyll found. Install Ruby for Windows (https://rubyinstaller.org) and run ' +
      "'bundle install' here, or set up Jekyll inside WSL and rerun with -Wsl."
