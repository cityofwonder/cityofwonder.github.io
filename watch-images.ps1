$date = Get-Date -Format "yyyy-MM-dd"
$watchPath = "$(Get-Location)\assets\images\$date"
New-Item -ItemType Directory -Force -Path $watchPath | Out-Null
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $watchPath
$watcher.Filter = "*.*"
$watcher.EnableRaisingEvents = $true
Write-Host "Watching: $watchPath" -ForegroundColor Cyan
Write-Host "Copy a file to trigger. Press Enter for filename as caption. Ctrl+C to exit."

# Block until a new file is created in the watched folder, return its name
function Wait-NewFile {
    while ($true) {
        $r = $watcher.WaitForChanged([System.IO.WatcherChangeTypes]::Created, 1000)
        if (-not $r.TimedOut) { return $r.Name }
    }
}

while ($true) {
    $result = $watcher.WaitForChanged([System.IO.WatcherChangeTypes]::Created, 1000)
    if (-not $result.TimedOut) {
        $name = $result.Name
        Write-Host "`nNew file: $name" -ForegroundColor Yellow
        $caption = Read-Host "Enter caption (or press Enter to skip)"

        if ([string]::IsNullOrWhiteSpace($caption)) {
            $caption = [System.IO.Path]::GetFileNameWithoutExtension($name)
        }

        $isPair = Read-Host "Is it a pair? (y/N)"
        if ($isPair -match '^[Yy]') {
            Write-Host "Pair mode: drop the SECOND image now..." -ForegroundColor Magenta
            $name2 = Wait-NewFile
            Write-Host "Second file: $name2" -ForegroundColor Yellow
            $output = @"
<figure class="img-pair">
    <div class="img-pair-row">
        <img src="/assets/images/$date/$name" alt="$caption">
        <img src="/assets/images/$date/$name2" alt="$caption">
    </div>
    <figcaption style="font-size: 0.9em; color: gray; margin-top: 5px;">$caption</figcaption>
</figure>
"@
        } else {
            $output = @"
<figure style="text-align: center;">
    <img src="/assets/images/$date/$name" alt="$caption">
    <figcaption style="font-size: 0.9em; color: gray; margin-top: 5px;">$caption</figcaption>
</figure>
"@
        }

        Write-Host $output -ForegroundColor Green
        Set-Clipboard $output
        Write-Host "(Copied to clipboard)" -ForegroundColor DarkGray
    }
}
