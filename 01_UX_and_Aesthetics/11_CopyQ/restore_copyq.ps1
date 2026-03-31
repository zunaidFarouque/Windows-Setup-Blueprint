# restore_copyq.ps1
$copyqAppdata = Join-Path $env:APPDATA "copyq"
$backupDir = Get-ChildItem -Path $PSScriptRoot -Directory -Filter "backup_*" |
    Sort-Object Name -Descending |
    Select-Object -First 1

if (-not $backupDir) {
    Write-Host "No backup_* folder found in $PSScriptRoot" -ForegroundColor Red
    exit 1
}

$backupRoot = $backupDir.FullName
$repoConfigDir = Join-Path $backupRoot "config-files"

Write-Host "Restoring CopyQ configurations..." -ForegroundColor Cyan
Write-Host "Backup folder: $backupRoot" -ForegroundColor DarkGray

function Wait-CopyQExited {
    param([int]$TimeoutSec = 45)
    $deadline = (Get-Date).AddSeconds($TimeoutSec)
    while (Get-Process -Name "copyq" -ErrorAction SilentlyContinue) {
        if ((Get-Date) -gt $deadline) {
            throw "CopyQ did not exit within ${TimeoutSec}s. Exit from the tray (Exit), then run this script again."
        }
        Start-Sleep -Milliseconds 400
    }
}

# Ask CopyQ to exit gracefully if CLI is available (closing the window is not enough)
$copyqCmd = Get-Command copyq -ErrorAction SilentlyContinue
if ($copyqCmd) {
    try {
        & copyq exit 2>$null
    } catch {
        # Ignore; we still force-stop below.
    }
}

Get-Process -Name "copyq" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Wait-CopyQExited

# Fresh-install files conflict with restored tab/settings INIs, so replace the whole config dir.
Remove-Item -LiteralPath $copyqAppdata -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $copyqAppdata | Out-Null

# List of specific files to restore
$filesToRestore = @(
    "copyq.ini",
    "copyq-commands.ini",
    "copyq_tabs.ini",
    "copyq-scripts.ini"
)

foreach ($file in $filesToRestore) {
    $sourcePath = Join-Path $repoConfigDir $file
    if (Test-Path -LiteralPath $sourcePath) {
        Copy-Item -LiteralPath $sourcePath -Destination (Join-Path $copyqAppdata $file) -Force
        Write-Host "Restored: $file" -ForegroundColor Gray
    } else {
        Write-Host "Skipped (not in repo): $file" -ForegroundColor Yellow
    }
}

# Clipboard tab data lives under items\; restore when the backup includes it.
$repoItems = Join-Path $repoConfigDir "items"
if (Test-Path -LiteralPath $repoItems) {
    Copy-Item -LiteralPath $repoItems -Destination (Join-Path $copyqAppdata "items") -Recurse -Force
    Write-Host "Restored: items\" -ForegroundColor Gray
}

Write-Host "CopyQ restore complete! You can now launch CopyQ." -ForegroundColor Green