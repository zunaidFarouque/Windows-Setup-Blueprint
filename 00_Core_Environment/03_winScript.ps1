$ErrorActionPreference = 'Stop'

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
  [Security.Principal.WindowsBuiltInRole]::Administrator
)

if (-not $isAdmin) {
  $argList = @(
    '-NoProfile'
    '-ExecutionPolicy', 'Bypass'
    '-File', $PSCommandPath
  ) + $args

  Start-Process -FilePath 'powershell.exe' -Verb RunAs -WorkingDirectory (Get-Location) -ArgumentList $argList
  exit
}

irm "https://winscript.cc/irm" | iex