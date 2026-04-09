## Winscript (system tweaks and setup script)

Run [winscript](https://github.com/flick9000/winscript) (**admin required**):

```powershell
irm "https://winscript.cc/irm" | iex
```

- This runs the winscript one-liner. It loads a system optimization and setup interface with various tweaks, updates, and optional installs. Review the options and apply what you need.

## Optimizers & hardening

(If not available in Portable apps folder) Download `Optimizer` manually: [https://github.com/hellzerg/optimizer/releases/download/16.7/Optimizer-16.7.exe](https://github.com/hellzerg/optimizer/releases/download/16.7/Optimizer-16.7.exe)
It provides quick privacy settings, debloating, and system performance tweaks.

## Disable GameDVR and Game Bar hooks

### Why use this tweak

- Reduces background capture hooks from Xbox Game Bar/GameDVR.
- Can lower background overhead during live audio, gaming, and recording workflows.
- Helps avoid accidental capture overlays and hotkey triggers.

### Why you might not use this tweak

- You lose built-in Xbox Game Bar capture/recording features.
- Some users rely on the overlay for quick screenshots, clips, or social features.
- Future Windows updates may reset parts of these values, requiring re-apply.

### Apply (PowerShell script)

- Script: [`04_Optimization_Scripts/Disable-GameDVR-GameBar.ps1`](04_Optimization_Scripts/Disable-GameDVR-GameBar.ps1)

## Disable Multi-Plane Overlay (MPO)

Windows 11 introduced Multi-Plane Overlay (MPO). On some NVIDIA Optimus laptops, it can cause dragging/UI stutter.  
This tweak applies a registry kill-switch so DWM uses the older, more stable composition path.
If you follow the NVIDIA driver installation workflow in [`12_Audio_and_VJ/Music/Live_Performance_Quick_Runbook.md` (Step 1)](../12_Audio_and_VJ/Music/Live_Performance_Quick_Runbook.md#step-1-one-time-work), this is already handled there.

### Apply (PowerShell as Administrator)

```powershell
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /t REG_DWORD /d 5 /f
```

Restart Windows after applying this change.


