# UX and Aesthetics software hub

This is the single source for UX/aesthetics software lists.

## Typing and text workflow

| Software                        | Install Method                                | What it does / Why I need it               |
| ------------------------------- | --------------------------------------------- | ------------------------------------------ |
| [CopyQ](../docs/CopyQ/copyq.md) | UniGetUI                                      | Clipboard manager with persistent history. |
| **WinMerge**                    | scoop_UGU                                     | Compare and merge files/folders.           |
| **WhisperTyping**               | [Manual](https://whispertyping.com/download/) | Voice typing with a generous free tier.    |
| **Typeless**                    | UniGetUI                                      | Auto-format and cleanup for dictated text. |

For CopyQ, you have to specify the WinMerge.exe location in the direct diff command.

WinMerge settings I use:

- Compare > General: moved block detection on, align similar lines on, diff algorithm `minimal`, indent heuristic on.
- Editor > Compare/Merge: copy granularity `Char`, view line differences on, line difference coloring character-level.

## Remote control

| Software     | Install Method | What it does / Why I need it        |
| ------------ | -------------- | ----------------------------------- |
| **Stardesk** | UniGetUI       | Current best remote desktop choice. |

## Listening music

| Software                                                        | Install Method                                          | What it does / Why I need it |
| --------------------------------------------------------------- | ------------------------------------------------------- | ---------------------------- |
| [foobar2000](Foobar_&_Deskband_Controls/1._foobar2000_Setup.md) | Manual (D)                                              | Play local downloaded songs. |
| **Harmony Music**                                               | [Manual (D)](https://github.com/anandnet/Harmony-Music) | Play and Download songs.     |
| **Muffon**                                                      | [scoop_UGU](https://muffon.netlify.app/)                | Discover new music.          |

## Lyrics management

| Software                         | Install Method                                   | What it does / Why I need it            |
| -------------------------------- | ------------------------------------------------ | --------------------------------------- |
| **Linkesoft Songbook (Windows)** | [Manual](https://www.linkesoft.com/songbook/pc/) | Manage ChordPro lyrics on PC.           |
| **Songbook Pro (Android)**       | [Manual](https://www.linkesoft.com/songbook/)    | Sync lyrics to mobile and cloud backup. |

In SongBook Pro (Android), I sync lyrics to Google Drive and keep periodic full local backups.

## Gaming input tools

| Software    | Install Method                    | What it does / Why I need it                     |
| ----------- | --------------------------------- | ------------------------------------------------ |
| **X360CE**  | [Manual](https://www.x360ce.com/) | Controller emulation for older/non-native games. |
| **HidHide** | UniGetUI                          | Hide physical controllers to avoid double input. |

## General UX and desktop tools

| Software                            | Install Method                                                                       | What it does / Why I need it                               |
| ----------------------------------- | ------------------------------------------------------------------------------------ | ---------------------------------------------------------- |
| **PowerToys**                       | UniGetUI                                                                             | Power-user utilities.                                      |
| **EverythingCmdPal**                | UniGetUI                                                                             | Search/launcher workflow.                                  |
| **Internet Download Manager (IDM)** | [Manual](https://www.internetdownloadmanager.com/)                                   | Download accelerator with browser integration and queuing. |
| **ContextMenuManager**              | scoop_UGU                                                                            | Clean and speed up right-click menu.                       |
| **Easy Context Menu**               | scoop_UGU                                                                            | Quick context menu toggles.                                |
| [Rainmeter](../docs/Rainmeter/)     | UniGetUI (D)                                                                         | Desktop widgets; setup details are in the repo guide.      |
| **Nearby share / Quick share**      | UniGetUI                                                                             | Fast local device file transfer.                           |
| **Kando**                           | scoop_UGU                                                                            | Radial launcher menu.                                      |
| **Custom Resolution Utility (CRU)** | [scoop_UGU](https://customresolutionutility.net/#download-custom-resolution-utility) | Fix/override display modes when EDID is wrong.             |
| **Wise Program Uninstaller**        | UniGetUI                                                                             | Clean uninstall when apps leave junk behind.               |
| **Wise Auto Shutdown**              | UniGetUI                                                                             | Scheduled shutdown/restart for maintenance.                |
| **XYPlorer**                        | [Manual (D)](https://www.xyplorer.com/download.php)                                  | Advanced dual-pane file manager and Explorer replacement.  |
| **Microsoft To Do**                 | UniGetUI                                                                             | Quick task capture and sync.                               |

## Social media

| Software                                        | Install Method | What it does / Why I need it                                                         |
| ----------------------------------------------- | -------------- | ------------------------------------------------------------------------------------ |
| [FB Messenger](13_FB_Messenger/fb_messenger.md) | Manual (D)     | Messenger app: opens messenger.com as a standalone window. See repo guide for setup. |
| **Telegram**                                    | scoop_UGU (D)  | Secure messaging with multi-device sync and channels.                                |

## System and diagnostics

| Software                       | Install Method | What it does / Why I need it                                        |
| ------------------------------ | -------------- | ------------------------------------------------------------------- |
| **Autoruns**                   | scoop_UGU      | Inspect and control startup entries and autoruns.                   |
| **BleachBit**                  | scoop_UGU      | Clean temporary files and reclaim storage space.                    |
| **CPU-Z**                      | scoop_UGU      | Check CPU, memory, and motherboard hardware details.                |
| **CrystalDiskInfo**            | scoop_UGU      | Monitor disk SMART health and temperatures.                         |
| **DebugView**                  | scoop_UGU      | Capture live Windows debug output during troubleshooting.           |
| **Detect It Easy (DIE)**       | scoop_UGU      | Identify packers, compilers, and executable signatures.             |
| **Firewall App Blocker**       | scoop_UGU      | Quickly block apps through Windows Firewall rules.                  |
| **PatchCleaner**               | scoop_UGU      | Find and clean orphaned Windows Installer patch files.              |
| **Process Explorer**           | scoop_UGU      | Deep process and handle inspection beyond Task Manager.             |
| **Process Hacker**             | scoop_UGU      | Advanced process and service monitoring and control.                |
| **Process Monitor**            | scoop_UGU      | Trace file, registry, and process activity in real time.            |
| **Registry Finder**            | scoop_UGU      | Faster registry search and editing workflow than RegEdit.           |
| **VCRedist 2022**              | scoop_UGU      | Install Microsoft Visual C++ runtime dependencies for many apps.    |
| **Ventoy**                     | scoop_UGU      | Maintain a multiboot USB drive without reformatting each new ISO.   |
| **Windows Update Blocker**     | scoop_UGU      | Toggle Windows Update services when tighter update control is needed. |
| **WizTree**                    | scoop_UGU      | Rapid disk usage analysis to find large folders and files.          |

## Productivity and file utilities

| Software               | Install Method | What it does / Why I need it                                  |
| ---------------------- | -------------- | ------------------------------------------------------------- |
| **7-Zip**              | scoop_UGU      | Archive extraction and compression utility.                   |
| **CCleaner**           | scoop_UGU      | Extra system cleanup and maintenance toolkit.                 |
| **Espanso**            | scoop_UGU      | System-wide text expansion for repeated snippets.             |
| **File Converter**     | scoop_UGU      | Context-menu file conversion for everyday formats.            |
| **Krokiet**            | scoop_UGU      | Data cleaner and deduper for large storage cleanup.           |
| **qBittorrent**        | scoop_UGU      | Torrent client for controlled peer-to-peer downloads.         |
| **ReNamer**            | scoop_UGU      | Rule-based bulk renaming for files and folders.               |
| **Rufus**              | scoop_UGU      | Create bootable USB drives from ISO images.                   |
| **Scoop Search**       | scoop_UGU      | Search Scoop buckets quickly from a dedicated helper tool.    |
| **ShareX**             | scoop_UGU      | Screenshot, capture, and share automation toolkit.            |
| **SpeedCrunch**        | scoop_UGU      | Desktop calculator with expression history and fast keyboard input. |

## Creative and media tools

| Software                     | Install Method | What it does / Why I need it                                |
| ---------------------------- | -------------- | ----------------------------------------------------------- |
| **Audacity**                 | scoop_UGU      | Record and edit audio clips quickly.                        |
| **Caesium Image Compressor** | scoop_UGU      | Compress images while keeping acceptable visual quality.    |
| **Calibre**                  | scoop_UGU      | Manage ebooks, metadata, and format conversion.             |
| **Dark**                     | scoop_UGU      | Decompile MSI installers to inspect their contents.         |
| **Darktable**                | scoop_UGU      | Non-destructive RAW photo workflow and color editing.       |
| **digiKam**                  | scoop_UGU      | Photo management, tagging, and batch organization.          |
| **HandBrake**                | scoop_UGU      | Video transcoding and compression for portable outputs.     |
| **Inkscape**                 | scoop_UGU      | Vector graphics editing and SVG work.                       |
| **OBS Studio**               | scoop_UGU      | Screen recording and live streaming toolkit.                |
| **PhotoDemon**               | scoop_UGU      | Lightweight portable image editor for quick edits.          |
| **PureRef**                  | scoop_UGU      | Reference-board canvas for visual inspiration and planning. |
| **RawTherapee**              | scoop_UGU      | Detailed RAW photo development and correction.              |
| **Shotcut**                  | scoop_UGU      | General-purpose video editing.                              |
| **Shutter Encoder**          | scoop_UGU      | Batch encode, remux, and convert media files.               |
| **Upscayl**                  | scoop_UGU      | AI upscaling for low-resolution images.                     |

## Music and notation

| Software             | Install Method | What it does / Why I need it                                |
| -------------------- | -------------- | ----------------------------------------------------------- |
| **FreePiano**        | scoop_UGU      | Virtual piano keyboard and MIDI practice tool.              |
| **JJazzLab**         | scoop_UGU      | Generate backing tracks for chord charts and practice.      |
| **MuseScore**        | scoop_UGU      | Music notation editing and score playback.                  |
| **OnTheSpot**        | scoop_UGU      | Grab and organize music downloads from supported services.  |
| **SolfegePortable**  | scoop_UGU      | Ear-training and sight-singing practice toolkit.            |

## Development and extraction tools

| Software         | Install Method | What it does / Why I need it                              |
| ---------------- | -------------- | --------------------------------------------------------- |
| **Innoextract**  | scoop_UGU      | Extract files from Inno Setup installers without running them. |
| **InnoUnp**      | scoop_UGU      | Unpack Inno Setup installers for inspection or recovery.  |
| **VSCodium**     | scoop_UGU      | VS Code-style editor without Microsoft branding/telemetry. |

## Privacy, communication, and access

| Software               | Install Method | What it does / Why I need it                                |
| ---------------------- | -------------- | ----------------------------------------------------------- |
| **Telegram Desktop**   | scoop_UGU      | Desktop package variant for Telegram messaging and file sharing. |
| **Tor Browser**        | scoop_UGU      | Privacy-focused browsing over the Tor network.              |
| **Zoom**               | scoop_UGU      | Video meetings, screen sharing, and calls.                  |

## Home and space planning

| Software            | Install Method | What it does / Why I need it                             |
| ------------------- | -------------- | -------------------------------------------------------- |
| **Sweet Home 3D**   | scoop_UGU      | Plan room layouts and interior arrangements in 2D and 3D. |
