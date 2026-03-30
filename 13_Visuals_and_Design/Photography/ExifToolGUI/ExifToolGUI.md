# ExifToolGUI — predefined commands

Backup of **Predefined commands** (ExifTool argument strings). ExifToolGUI does not export these; this file is the source of truth for reinstalls or new machines.

**Restore:** In ExifToolGUI, add or edit each predefined command and paste the matching argument block below.

Replace `MyName` / `My Name` with your name where used.

---

### Set Exif Copyright (year from `DateTimeOriginal`)

Writes `Exif:Copyright` as `©<date> by <name>` using the photo’s original date.

```
-d %Y "-Exif:Copyright<©$DateTimeOriginal by MyName"
```

### Align Windows file create date with modify date

Sets **FileCreateDate** from **FileModifyDate**.

```
-FileCreateDate<FileModifyDate
```

### Set EXIF CreateDate from file create date

Sets **CreateDate** from **FileCreateDate**.

```
-CreateDate<FileCreateDate
```

### Set DateTimeOriginal from file create date

Sets **DateTimeOriginal** from **FileCreateDate**.

```
-DateTimeOriginal<FileCreateDate
```

### Extract all embedded binaries (jpg/jpeg/tiff)

Outputs under `extractedPics/` with type-specific extensions.

```
-a -b -W extractedPics/%f_%t%c.%s -Wext jpg -Wext jpeg -Wext tiff -Wext tif
```

### Samsung Portrait — extract embedded original (unblurred)

Pulls Samsung’s embedded image; writes beside source path layout via `%g1\%t\`.

```
-b -W %g1\%t\%f.%s -Samsung:EmbeddedImage
```

---

## Quick add via `ExifToolGuiV6.ini`

1. Open `ExifToolGuiV6.ini` from your existing ExifToolGUI installation.

2. Paste or replace the entire `[ETdirectCmd]` section with:

```
[ETdirectCmd]
Set Exif:Copyright to [©Year by MyName]=-d %Y "-Exif:Copyright<©$DateTimeOriginal by MyName"
file modify date to file create date=-FileCreateDate<FileModifyDate
file create date to Create date=-CreateDate<FileCreateDate
Create date to Date time orignal=-DateTimeOriginal<FileCreateDate
Extract Embedded binary all=-a -b -W extractedPics/%f_%t%c.%s -Wext jpg -Wext jpeg -Wext tiff -Wext tif
Extract Original (Unblurred) from Samsung Portrait=-b -W %g1\%t\%f.%s -Samsung:EmbeddedImage
```

Close ExifToolGUI before editing; restart it after saving.
