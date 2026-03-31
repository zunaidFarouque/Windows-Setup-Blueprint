# CopyQ setup

## Why CopyQ?

CopyQ is the clipboard manager I keep because it is lightweight, scriptable, and easy to carry across reinstalls once the config is backed up properly.

## Backup

Run `backup_copyq.ps1`.
The script creates a new timestamped `backup_*` folder in this directory, then packages that folder together with `backup_copyq.ps1` and `restore_copyq.ps1` into `CopyQ_Latest_Backup.zip`.
For long-term backup, keep the `CopyQ_Latest_Backup.zip` file.

## Restore

1. Install CopyQ on the fresh Windows setup.
2. Extract [`CopyQ_Latest_Backup.zip`](./CopyQ_Latest_Backup.zip) into any folder.
3. Make sure CopyQ is fully closed.
4. Run `restore_copyq.ps1`.
   The script automatically restores from the newest `backup_*` folder next to it, replaces `%APPDATA%\copyq`, and restores the saved `items` folder when present.

## WinMerge integration

To compare the latest two clipboard entries in WinMerge:

1. Install WinMerge and configure it according to your diff workflow.
2. Open CopyQ and press `F6`.
3. Find the `Diff Latest Items` command.
4. If needed, replace the default executable with the full portable path.

Default form:

```text
execute('winmergeu', '/e', '/x', '/u', '/fl', '/dl', 'item1', '/dr', 'item2', name1, name2)
```

Portable-path example:

```text
execute('D:/_installed/scoop/apps/winmerge/current/winmergeu.exe', '/e', '/x', '/u', '/fl', '/dl', 'item1', '/dr', 'item2', name1, name2)
```
