| Software                            | Install Method | What it does / Why I need it                                                                    |
| ----------------------------------- | -------------- | ----------------------------------------------------------------------------------------------- |
| **_🔶 System and Diagnostics_**     |                |                                                                                                 |
| **Autoruns**                        | scoop_UGU      | Inspect and control startup entries and autoruns.                                               |
| **BleachBit**                       | scoop_UGU      | Cleanup temporary files and reclaim storage space.                                              |
| **CPU-Z**                           | scoop_UGU      | Hardware identification for CPU, memory, and board details.                                     |
| **CrystalDiskInfo**                 | scoop_UGU      | Disk health monitoring via SMART status and temperatures.                                       |
| **Detect It Easy (DIE)**            | scoop_UGU      | Identify packers, compilers, and executable signatures.                                         |
| **Registry Finder**                 | scoop_UGU      | Faster registry search/edit workflow than stock RegEdit.                                        |
| **Custom Resolution Utility (CRU)** | UniGetUI (C)   | Fix/override display modes (EDID). I used it to get 90hz, 120hz etc on my 360hz laptop display. |
| **Process Explorer**                | scoop_UGU      | Deep process and handle inspection beyond Task Manager.                                         |
| **Process Hacker**                  | scoop_UGU      | Advanced process/service monitoring and control.                                                |
| **Process Monitor**                 | scoop_UGU      | Real-time file, registry, and process activity tracing.                                         |
| **Ventoy**                          | scoop_UGU      | Multi-ISO boot media management and updates.                                                    |
| **WizTree**                         | scoop_UGU      | Rapid disk usage analysis to find large folders/files.                                          |
| **_🔶 Productivity and Utilities_** |                |                                                                                                 |
| **Krokiet**                         | scoop_UGU      | Data cleaner and deduper for large storage cleanup.                                             |
| **qBittorrent**                     | scoop_UGU      | Torrent client for controlled peer-to-peer downloads.                                           |
| **ReNamer**                         | scoop_UGU      | Rule-based bulk file and folder renaming.                                                       |
| **Rufus**                           | scoop_UGU      | Create bootable USB drives from ISO images.                                                     |
| **ShareX**                          | scoop_UGU      | Screenshot, capture, and share automation toolkit.                                              |
| **SpeedCrunch**                     | scoop_UGU      | Powerful desktop calculator with expression history.                                            |
| **Telegram Desktop**                | scoop_UGU      | Portable messaging client and file sharing endpoint.                                            |
| **WinMerge**                        | scoop_UGU      | File/folder diff and merge for change tracking.                                                 |

---

## Quick Start

- `Copy_Shortcuts_to_StartMenu.ps1`: Copies shortcut files from `D:\_installed\_Shortcuts` into a dedicated Start Menu folder (`My Portable Apps`) so portable apps show up like normal installed apps. It also clears Explorer's icon cache and restarts Explorer so shortcut icons refresh properly.
- `Portable_Apps_with_Scoop_UniGetUI.ubundle`: UniGetUI export bundle for this portable ecosystem. Useful as a restore/import snapshot for the Scoop and Winget app set managed through the `scoop_UGU` workflow.

> **Note:** Additional software installed and managed via the scoop_UGU platform can be found in the specialized software tables—for example, see [13_Visuals_and_Design/Designing/Designing.md](../13_Visuals_and_Design/Designing/Designing.md) for visual design tools. Explore these separate lists for more targeted app categories.
