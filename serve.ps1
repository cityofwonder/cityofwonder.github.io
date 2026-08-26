# Launch the Jekyll dev server inside WSL.
# livereload + force_polling are configured in _config.yml, so no extra flags needed.
# Usage (from this folder):  powershell -ExecutionPolicy Bypass -File .\serve.ps1
#   or just right-click -> Run with PowerShell

$ErrorActionPreference = 'Stop'

# Map this script's Windows path to its WSL (/mnt/c/...) equivalent
$linuxPath = (wsl wslpath -a "$PSScriptRoot").Trim()

Write-Host "Serving Jekyll from $linuxPath (Ctrl+C to stop)..." -ForegroundColor Cyan
Write-Host "  http://127.0.0.1:4000`n" -ForegroundColor Cyan

# -l : login shell so rbenv/gem PATH + `bundle config path` are loaded
wsl bash -lc "cd '$linuxPath' && bundle exec jekyll serve --livereload"
