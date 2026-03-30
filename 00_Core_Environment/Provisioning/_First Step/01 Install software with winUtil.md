# Install software with WinUtil (fast runbook)

Goal: **install baseline apps** + **apply standard tweaks**, then move on.

## Inputs (from this repo)

- **O&O profile**: `00_Core_Environment/Provisioning/_First Step/WinUtil Things/ooshutup10.cfg`

## Launch WinUtil (stable)

PowerShell **as Administrator**:

```powershell
irm "https://christitus.com/win" | iex
```

## Install apps (import + run)

UniGetUI depends on Windows Update components. Keep Windows Update services enabled (do not fully disable Windows Update) or UniGetUI package operations can fail.

1. WinUtil → **Settings (gear)** → **Import**
2. Select `00_Core_Environment/Provisioning/_First Step/WinUtil Things/Basic Software Installs.json`
3. Go **Install** tab → verify selections populated
4. Run the **install/apply** action for the selected apps

## Tweaks + O&O ShutUp10++

1. WinUtil → **Tweaks** → run your standard tweak set
2. From WinUtil, **launch O&O ShutUp10++**
3. O&O → **File → Import** → select `00_Core_Environment/Provisioning/_First Step/WinUtil Things/ooshutup10.cfg`
4. Apply (reboot if prompted/needed)

## Done / exit criteria

- Baseline apps installed (includes UniGetUI)
- O&O profile imported and applied
- Reboot completed if required
