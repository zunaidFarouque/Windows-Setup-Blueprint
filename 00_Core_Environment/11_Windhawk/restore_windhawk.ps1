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

$windhawkData = Join-Path $env:ProgramData "Windhawk"
$backupDir = Get-ChildItem -Path $PSScriptRoot -Directory -Filter "backup_*" |
    Sort-Object Name -Descending |
    Select-Object -First 1

if (-not $backupDir) {
    Write-Host "No backup_* folder found in $PSScriptRoot" -ForegroundColor Red
    exit 1
}

$backupRoot = $backupDir.FullName

Write-Host "Restoring Windhawk mods and settings..." -ForegroundColor Cyan
Write-Host "Backup folder: $backupRoot" -ForegroundColor DarkGray

# 1. Stop Windhawk Service so files aren't locked
Write-Host "Stopping Windhawk service..." -ForegroundColor Gray
Stop-Service -Name "WindhawkService" -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

# 2. Import registry settings from the long-term backup files
$registryFiles = @("Engine_Mods.reg", "Engine_ModsWritable.reg")

foreach ($registryFile in $registryFiles) {
    $registryPath = Join-Path $backupRoot $registryFile

    if (Test-Path $registryPath) {
        reg import "$registryPath" | Out-Null
        Write-Host "Imported: $registryFile" -ForegroundColor Gray
    } else {
        Write-Host "Skipped (Not Found): $registryFile" -ForegroundColor Yellow
    }
}

# 3. Restore the portable mod source files
$modsSourceBackupPath = Join-Path $backupRoot "ModsSource"
$modsSourceTargetPath = Join-Path $windhawkData "ModsSource"

if (Test-Path $modsSourceBackupPath) {
    New-Item -ItemType Directory -Force -Path $modsSourceTargetPath | Out-Null
    Copy-Item -Path (Join-Path $modsSourceBackupPath "*") -Destination $modsSourceTargetPath -Recurse -Force
    Write-Host "Restored: ModsSource" -ForegroundColor Gray
} else {
    Write-Host "Skipped (Not Found): ModsSource" -ForegroundColor Yellow
}

# 4. Restart Windhawk Service to apply mods
Write-Host "Restarting Windhawk service..." -ForegroundColor Gray
Start-Service -Name "WindhawkService" -ErrorAction SilentlyContinue

Write-Host "Windhawk restore complete!" -ForegroundColor Green