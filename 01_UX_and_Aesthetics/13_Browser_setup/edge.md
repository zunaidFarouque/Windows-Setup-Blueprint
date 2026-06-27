# Microsoft Edge setup

## Pin multiple profiles (taskbar + Start)

### Recommended

1. Open Edge with each profile you want pinned.
2. Right-click its taskbar button → **Pin to taskbar**.
3. Right-click again → **Pin to Start**.

Windows treats each running profile as its own taskbar entry, so pinning stays profile-specific.

### Manual shortcut fallback

If needed, create shortcuts with these targets, then pin them:

- `"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --profile-directory=Default`
- `"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --profile-directory="Profile 1"`

Profile folder names must match what Edge created (`edge://version` or `edge://settings/profiles`).

## Built-in mouse gestures

Configure: Edge → **Settings** → **Appearance** → **Mouse gestures** (`edge://settings/appearance`).

### Single-stroke

| Gesture | Action |
| ------- | ------ |
| Left | Go back |
| Right | Forward |
| Up | No action |
| Down | No action |

### Two-stroke

| Gesture | Action |
| ------- | ------ |
| Down → right | Close tab |
| Down → left | Reopen closed tab |
| Left → up | New window |
| Right → up | Open new tab |
| Right → down | Refresh |
| Left → down | Refresh |
| Up → left | Switch to left tab |
| Up → right | Switch to right tab |
| Up → down | Scroll to bottom |
| Down → up | Scroll to top |
| Left → right | No action |
| Right → left | No action |

## Navigation

- [← Browser setup](browser_setup.md)
- [FB Messenger setup](FB_Messenger/fb_messenger.md)
- [UX hub](../Software.md)
