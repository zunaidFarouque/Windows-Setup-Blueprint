# Install software (UniGetUI + System) — fast runbook

Run this after WinUtil: [01 Install software with WinUtil.md](01%20Install%20software%20with%20WinUtil.md)

## First-run setup

Go to UniGetUI Settings and install/enable anything needed to activate WinGet, Chocolatey, and Scoop.

# Things to install (UniGetUI + manual system tools)

| Software                                  | Install Method                                                              | What it does / Why I need it                    |
| ----------------------------------------- | --------------------------------------------------------------------------- | ----------------------------------------------- |
| **_🔶 Core defaults_**                    |                                                                             |                                                 |
| **Cloudflare WARP**                       | UniGetUI                                                                    | VPN/DNS for blocked/bad networks.               |
| **Avro Keyboard**                         | UniGetUI                                                                    | Bangla typing.                                  |
| **Everything**                            | UniGetUI                                                                    | Instant file search.                            |
| **WinRAR**                                | UniGetUI                                                                    | Archive tool (RAR/ZIP/etc).                     |
| **Notepad++**                             | UniGetUI                                                                    | Lightweight editor for ops work.                |
| **TeraCopy**                              | UniGetUI                                                                    | Better copy/move with retries and queue.        |
| **Bulk Crap Uninstaller (BCUninstaller)** | UniGetUI                                                                    | Bulk uninstall apps and remove leftovers fast.  |
| **_🔶 Media_**                            |                                                                             |                                                 |
| **FastStone Image Viewer**                | UniGetUI                                                                    | Fast local image viewer for quick triage.       |
| **MPC-BE**                                | UniGetUI                                                                    | Lean media player.                              |
| **VLC**                                   | UniGetUI                                                                    | Backup player for odd formats/streams.          |
| **FFmpeg**                                | UniGetUI                                                                    | CLI media swiss-army knife.                     |
| **K-Lite Codec Pack**                     | UniGetUI                                                                    | Wide codec support.                             |
| **LAV Filters**                           | UniGetUI                                                                    | Decoder/filter stack for players.               |
| **CopyTrans HEIC**                        | [Manual](https://www.copytrans.net/copytransheic/)                          | HEIC/HEIF support in Windows Explorer/apps.     |
| **_🔶 Display & shell_**                  |                                                                             |                                                 |
| **EarTrumpet**                            | UniGetUI                                                                    | Per-app audio control.                          |
| [Windhawk](11%20Windhawk/windhawk.md)     | UniGetUI                                                                    | Windows UI tweaks via mods.                     |
| **_🔶 Core runtimes / deps_**             |                                                                             |                                                 |
| **VC++ Redistributables (AIO)**           | [Manual](https://github.com/abbodi1406/vcredist/releases)                   | One-shot install of common VC++ runtimes.       |
| **DirectX End-User Runtimes (Jun 2010)**  | [Manual](https://www.microsoft.com/en-us/download/details.aspx?id=8109)     | Legacy DirectX components for older apps/games. |
| **.NET Desktop Runtime (latest)**         | [Manual](https://dotnet.microsoft.com/en-us/download/dotnet/latest/runtime) | Required by many modern Windows desktop apps.   |
| **IObit Driver Booster**                  | [Manual (D)](https://www.iobit.com/en/driver-booster.php)                   | Quick driver + “game components” install.       |

---

## After this: Winscript (system tweaks and setup script)

Run [winscript](https://github.com/flick9000/winscript) (**admin required**):

```powershell
irm "https://winscript.cc/irm" | iex
```

- This runs the winscript one-liner. It loads a system optimization and setup interface with various tweaks, updates, and optional installs. Review the options and apply what you need.

### Optimizers & hardening

(If not available in Portable apps folder) Download Optimizer manually: [https://github.com/hellzerg/optimizer/releases/download/16.7/Optimizer-16.7.exe](https://github.com/hellzerg/optimizer/releases/download/16.7/Optimizer-16.7.exe)
It provides quick privacy settings, debloating, and system performance tweaks.
