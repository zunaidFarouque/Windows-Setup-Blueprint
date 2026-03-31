# Define your source folder and the name of the Start Menu folder you want
$sourceDir = "D:\_installed\_Shortcuts" # CHANGE THIS to your actual folder
$targetSubDir = "My Portable Apps"    # CHANGE THIS to Start Menu folder name

# Build the path to the current user's Start Menu Programs folder
$startMenuPath = [System.IO.Path]::Combine($env:APPDATA, "Microsoft\Windows\Start Menu\Programs", $targetSubDir)

# Create the specific subdirectory if it doesn't already exist
if (!(Test-Path -Path $startMenuPath)) {
    New-Item -ItemType Directory -Path $startMenuPath | Out-Null
    Write-Host "Created new Start Menu directory: $startMenuPath" -ForegroundColor Green
}

# Grab all files in the source directory and copy them over
# -Force ensures existing files are overwritten, updating their icons/targets
Get-ChildItem -Path $sourceDir -File | ForEach-Object {
    $destPath = [System.IO.Path]::Combine($startMenuPath, $_.Name)
    Copy-Item -Path $_.FullName -Destination $destPath -Force
    Write-Host "Synced: $($_.Name)" -ForegroundColor Cyan
}

Write-Host "Done. Check your Start Menu." -ForegroundColor Green

#######
# Refresh Thumbnail Cache
#######

# Stop Windows Explorer gracefully-ish
Stop-Process -Name explorer -Force

# Nuke the hidden icon cache databases in your local app data
$cachePath = "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\iconcache*"
Remove-Item -Path $cachePath -Force -Recurse -ErrorAction SilentlyContinue

# Bring Explorer (and your taskbar) back to life
Start-Process explorer

Write-Host "Icon cache cleared." -ForegroundColor Green