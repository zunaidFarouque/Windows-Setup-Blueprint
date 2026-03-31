function Test-IsAdministrator {
    $currentIdentity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentIdentity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-IsAdministrator)) {
    Write-Host "Requesting administrator privileges..." -ForegroundColor Yellow
    Start-Process -FilePath "powershell.exe" -Verb RunAs -ArgumentList @(
        "-NoProfile",
        "-ExecutionPolicy", "Bypass",
        "-File", "`"$PSCommandPath`""
    )
    exit
}

$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$backupRoot = Join-Path $PSScriptRoot "backup_$timestamp"
$backupFolderName = Split-Path $backupRoot -Leaf
$windhawkData = Join-Path $env:ProgramData "Windhawk"
$archivePath = Join-Path $PSScriptRoot "Windhawk_Latest_Backup.zip"

New-Item -ItemType Directory -Force -Path $backupRoot | Out-Null

Write-Host "Backing up Windhawk mods and settings..." -ForegroundColor Cyan
Write-Host "Backup folder: $backupRoot" -ForegroundColor DarkGray

# 1. Export the Windhawk registry keys needed for manual restore
$registryExports = @(
    @{
        Key = "HKLM\SOFTWARE\Windhawk\Engine\Mods"
        File = "Engine_Mods.reg"
    },
    @{
        Key = "HKLM\SOFTWARE\Windhawk\Engine\ModsWritable"
        File = "Engine_ModsWritable.reg"
    }
)

foreach ($registryExport in $registryExports) {
    $registryBackupPath = Join-Path $backupRoot $registryExport.File
    reg export $registryExport.Key "$registryBackupPath" /y | Out-Null
    Write-Host "Exported: $($registryExport.Key)" -ForegroundColor Gray
}

# 2. Backup the portable Windhawk source files
$modsSourcePath = Join-Path $windhawkData "ModsSource"
$modsSourceBackupPath = Join-Path $backupRoot "ModsSource"

if (Test-Path $modsSourcePath) {
    $itemsToCopy = Get-ChildItem -Path $modsSourcePath -Force

    if ($itemsToCopy.Count -gt 0) {
        New-Item -ItemType Directory -Force -Path $modsSourceBackupPath | Out-Null
        Copy-Item -Path (Join-Path $modsSourcePath "*") -Destination $modsSourceBackupPath -Recurse -Force
        Write-Host "Copied: ModsSource" -ForegroundColor Gray
    } else {
        Write-Host "Skipped (Empty): ModsSource" -ForegroundColor DarkYellow
    }
} else {
    Write-Host "Skipped (Not Found): ModsSource" -ForegroundColor Yellow
}

# 3. Package the latest backup with the backup and restore scripts
if (Test-Path $archivePath) {
    Remove-Item -Path $archivePath -Force
}

Push-Location $PSScriptRoot
try {
    Compress-Archive -Path @(
        $backupFolderName,
        "backup_windhawk.ps1",
        "restore_windhawk.ps1"
    ) -DestinationPath $archivePath -Force
} finally {
    Pop-Location
}

if (Test-Path $archivePath) {
    Remove-Item -Path $backupRoot -Recurse -Force
    Write-Host "Archive created: $archivePath" -ForegroundColor Gray
    Write-Host "Removed temporary folder: $backupFolderName" -ForegroundColor Gray
} else {
    Write-Host "Archive was not created. Keeping backup folder: $backupFolderName" -ForegroundColor Yellow
}

Write-Host "Windhawk long-term backup successfully saved." -ForegroundColor Green