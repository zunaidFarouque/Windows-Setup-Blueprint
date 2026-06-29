# Nilesoft Shell setup

## Why Nilesoft Shell?

Nilesoft Shell replaces the truncated Windows 11 “Show more options” flow with a single, fully customizable right-click menu. This repo keeps the full `nss` tree under [`nss files/`](./nss%20files/) so a reinstall is mostly copy-and-reload.

Official docs: [Installation](https://nilesoft.org/docs/installation) · [Configuration](https://nilesoft.org/docs/configuration) · [Get started](https://nilesoft.org/docs/get-started)

Deep reference: [`NILESOFT_SHELL_EXPERT_GUIDE.md`](./NILESOFT_SHELL_EXPERT_GUIDE.md)

## Install

1. Install Shell (for example `winget install nilesoft.shell` in an elevated terminal, or use the installer from [nilesoft.org](https://nilesoft.org/)).
2. Let the installer restart Explorer when prompted.

Default install folder: `C:\Program Files\Nilesoft Shell\`

## Deploy this configuration

1. Back up the stock `shell.nss` and `imports\` folder in the install directory.
2. Copy everything from [`nss files/`](./nss%20files/) into `C:\Program Files\Nilesoft Shell\` (replace `shell.nss` and merge `imports\`).
3. Reload: **Ctrl + right-click** on the desktop or taskbar, or restart Explorer.

Open the live config folder quickly: **Shift + right-click** the taskbar → **Shell** → **Directory**.

If something fails to load, check `shell.log` in the same install directory.

---

## `shell.nss` — entry point and load order

[`nss files/shell.nss`](./nss%20files/shell.nss) is the root file Nilesoft reads. It sets global behavior, declares shared menu anchors, then pulls in modules in a fixed order.

### Global settings

| Setting | Value | Effect |
| -------- | ----- | ------ |
| `priority` | `1` | Shell menu takes precedence over the default handler where applicable. |
| `exclude.where` | `!process.is_explorer` | Only hooks Explorer-hosted context menus (not arbitrary apps). |
| `showdelay` | `200` | Menu show delay (ms). |
| `modify.remove.duplicate` | `1` | Collapses duplicate entries after `modify` rules run. |
| `tip.enabled` | `true` | Tooltips on items that define them. |

### Shared menu placeholders

Two empty multi-select menus are declared up front so other files can **move** items into them by title:

- **Pin/Unpin** (`icon.pin`)
- **More options** (`icon.more_options`) — used by `custom.nss` for overflow items

### Active imports (in order)

| Module | Role |
| ------ | ---- |
| `imports/theme.nss` | Look and feel (colors, fonts, effects). |
| `imports/images.nss` | Icon definitions used across menus. |
| `imports/modify.nss` | Stock `modify` / `remove` tweaks from the default template. |
| `imports/file-manage.nss` | **File manage** group (copy path, attributes, take ownership, etc.). Required before `custom.nss` moves items into that group. |
| `imports/taskbar.nss` | Taskbar-specific Shell entries (docs/donate links). |
| `imports/custom.nss` | **This repo’s personal menu layout** (documented below). |
| `imports/recycle.bin.nss` | Recycle Bin cleaning / retention snippets (RubicBG). |
| `imports/goto.reg.nss` | **Go to** registry-backed locations. |

### Intentionally disabled imports

These lines are commented out in `shell.nss` and are **not** loaded:

- `terminal.nss`, `develop.nss`
- `all.security.env.nss`, `all.security.permissions.nss` (copies live under `imports/not using/`)
- `goto.nss`, `goto.temp.nss`

### Taskbar cleanup (in `shell.nss`)

```nss
remove(type="taskbar" find=title.desktop)
```

Removes the redundant **Desktop** entry from the taskbar context menu. The same rule also appears at the end of `custom.nss` (harmless duplicate).

---

## `custom.nss` — personal menu layout

[`nss files/imports/custom.nss`](./nss%20files/imports/custom.nss) runs after **File manage** exists, so `modify(... menu="File manage")` and `menu="More options"` resolve correctly.

### Removed clutter

These built-in or third-party entries are stripped from the menu:

| `find` target |
| ------------- |
| Add to Windows Media Player Legacy list |
| Play with Windows Media Player Legacy |
| Add to Favorites |
| Browse with FastStone |

### Re-grouped items

| Item | Destination |
| ---- | ----------- |
| New folder with selection | **File manage** (with `icon.new_folder`) |
| NanaZip, 7-Zip, WinRAR, Extract All... | **Archiving Tools** (new submenu, icon `\uE186`) |
| Scan with Microsoft Defender | **More options** |
| Blip | **More options** |

### **Open in...** (Shift-only launch menu)

A submenu titled **Open in...** appears only when:

- Context: directory, parent directory, drive, parent drive, or desktop
- **Shift** is held
- At most **one** item is selected

Contents:

| Section | Items | Notes |
| ------- | ----- | ----- |
| Search | Search with Everything | Needs [Everything](https://www.voidtools.com/) at `C:\Program Files\Everything 1.5a\Everything.exe`; runs `-search "@sel.path "`. |
| Terminals | Command Prompt, Windows PowerShell, Windows Terminal | **Shift** (or right-click where applicable) elevates via `admin=has_admin` and shows a warning tip. CMD/PowerShell open in `@sel.dir`; WT uses `wt.exe -d "@sel.path\."` when the `WindowsTerminal` package exists. |
| Editors | VSCodium, Cursor, Visual Studio | `codium` / `cursor` on `"@sel.path"`, hidden console window. Visual Studio is the native shell item moved into this submenu when Visual Studio registers it. |

### **System Maintenance** (Recycle Bin only)

On the Recycle Bin CLSID (`::{645FF040-5081-101B-9F08-00AA002F954E}`):

| Item | Behavior |
| ---- | -------- |
| Flush DNS Cache | Admin; runs `ipconfig /flushdns`, brief success message, 2s pause |

Complements the richer **Cleaning / Recycling** block from `recycle.bin.nss` on the same target.

### Taskbar

Same desktop-entry removal as `shell.nss` (see above).

---

## Dependencies checklist

Install or PATH-adjust these before expecting every **Open in...** entry to work:

| Tool | Used for |
| ---- | -------- |
| Everything 1.5a | Shift menu → Search with Everything |
| Windows Terminal (`wt.exe`) | Shift menu → Windows Terminal |
| VSCodium (`codium` on PATH) | Shift menu → VSCodium |
| Cursor (`cursor` on PATH) | Shift menu → Cursor |
| Visual Studio shell extension | Shift menu → Open with Visual Studio |
| NanaZip / 7-Zip / WinRAR | **Archiving Tools** submenu (entries hidden if not installed) |
| Microsoft Defender | **More options** → Scan with Microsoft Defender |

## Quick reference

| Action | Gesture |
| ------ | ------- |
| Reload config after edit | **Ctrl + right-click** (desktop or taskbar) |
| Open Shell install folder | **Shift + right-click** taskbar → Shell → Directory |
| Open **Open in...** submenu | **Shift + right-click** on folder/drive/desktop (≤1 selection) |
| Run terminal item as admin | Hold **Shift** when clicking (see `$tip_run_admin` in `custom.nss`) |

## Backup for reinstalls

Archive the whole [`nss files/`](./nss%20files/) tree (or the entire `C:\Program Files\Nilesoft Shell\` folder after you deploy). After a clean install, copy it back and reload—no need to rebuild menus by hand.
