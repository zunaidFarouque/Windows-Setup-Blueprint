$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$backupRoot = Join-Path $PSScriptRoot "backup_$timestamp"
$backupFolderName = Split-Path $backupRoot -Leaf
$copyqAppdata = Join-Path $env:APPDATA "copyq"
$archivePath = Join-Path $PSScriptRoot "CopyQ_Latest_Backup.zip"
$backupConfigDir = Join-Path $backupRoot "config-files"

New-Item -ItemType Directory -Force -Path $backupConfigDir | Out-Null

Write-Host "Backing up CopyQ configurations..." -ForegroundColor Cyan
Write-Host "Backup folder: $backupRoot" -ForegroundColor DarkGray

$filesToBackup = @(
    "copyq.ini",
    "copyq-commands.ini",
    "copyq_tabs.ini",
    "copyq-scripts.ini"
)

foreach ($file in $filesToBackup) {
    $sourcePath = Join-Path $copyqAppdata $file
    if (Test-Path -LiteralPath $sourcePath) {
        Copy-Item -LiteralPath $sourcePath -Destination (Join-Path $backupConfigDir $file) -Force
        Write-Host "Copied: $file" -ForegroundColor Gray
    } else {
        Write-Host "Skipped (Not Found): $file" -ForegroundColor Yellow
    }
}

$itemsSource = Join-Path $copyqAppdata "items"
if (Test-Path -LiteralPath $itemsSource) {
    Copy-Item -LiteralPath $itemsSource -Destination (Join-Path $backupConfigDir "items") -Recurse -Force
    Write-Host "Copied: items\" -ForegroundColor Gray
} else {
    Write-Host "Skipped (Not Found): items\" -ForegroundColor Yellow
}

if (Test-Path -LiteralPath $archivePath) {
    Remove-Item -LiteralPath $archivePath -Force
}

Push-Location $PSScriptRoot
try {
    Compress-Archive -Path @(
        $backupFolderName,
        "backup_copyq.ps1",
        "restore_copyq.ps1"
    ) -DestinationPath $archivePath -Force
} finally {
    Pop-Location
}

if (Test-Path -LiteralPath $archivePath) {
    Remove-Item -LiteralPath $backupRoot -Recurse -Force
    Write-Host "Archive created: $archivePath" -ForegroundColor Gray
    Write-Host "Removed temporary folder: $backupFolderName" -ForegroundColor Gray
} else {
    Write-Host "Archive was not created. Keeping backup folder: $backupFolderName" -ForegroundColor Yellow
}

Write-Host "CopyQ long-term backup successfully saved." -ForegroundColor Green