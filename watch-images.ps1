$date = Get-Date -Format "yyyy-MM-dd"
$watchPath = "$(Get-Location)\assets\images\$date"

New-Item -ItemType Directory -Force -Path $watchPath | Out-Null

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $watchPath
$watcher.Filter = "*.*"
$watcher.EnableRaisingEvents = $true

Write-Host "Watching: $watchPath" -ForegroundColor Cyan
Write-Host "Copy a file to trigger. Ctrl+C to exit."

while ($true) {
    $result = $watcher.WaitForChanged([System.IO.WatcherChangeTypes]::Created, 1000)
    if (-not $result.TimedOut) {
        $name = $result.Name
        Write-Host "`nNew file: $name" -ForegroundColor Yellow
        $caption = Read-Host "Enter caption"
        
        $output = @"
<figure style="text-align: center;">
    <img src="/assets/images/$date/$name" alt="$caption">
    <figcaption style="font-size: 0.9em; color: gray; margin-top: 5px;">$caption</figcaption>
</figure>
"@
        Write-Host $output -ForegroundColor Green
    }
}
