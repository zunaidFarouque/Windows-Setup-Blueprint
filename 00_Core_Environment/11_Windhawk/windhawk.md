# Windhawk Setup

## Why Windhawk?

Windhawk replaces the need for messy, permanent registry hacks or obscure tweakers. It acts as a transparent, open-source marketplace that safely injects mods into Windows processes in real-time. If something breaks, simply disabling the mod safely reverts the system behavior immediately.

## 📤 How to Backup

Run `backup_windhawk.ps1` as Administrator.
The script creates a new timestamped `backup_*` folder in this directory, then packages that folder together with `backup_windhawk.ps1` and `restore_windhawk.ps1` into `Windhawk_Latest_Backup.zip`.
For long-term backup, keep the `Windhawk_Latest_Backup.zip` file.

## 📥 How to Restore

1. Install the Windhawk application on the fresh Windows setup.
2. Extract [`Windhawk_Latest_Backup.zip`](./Windhawk_Latest_Backup.zip) into any folder.
3. Run `restore_windhawk.ps1` as Administrator.
   The script automatically restores from the newest `backup_*` folder next to it, imports the saved registry settings, copies `ModsSource`, and restarts the Windhawk service.
