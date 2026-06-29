# Nilesoft Shell Expert Guide

This is the long-form field guide for maintaining and extending this repository's Nilesoft Shell configuration. It preserves the important research findings from official documentation, GitHub issues/discussions, community snippets, and this repo's working configuration so a future AI or human can reason about Shell without rediscovering the same traps.

Repository context:

- Root setup note: [`nilesoft_shell.md`](./nilesoft_shell.md)
- Entry point: [`nss files/shell.nss`](./nss%20files/shell.nss)
- Personal layout: [`nss files/imports/custom.nss`](./nss%20files/imports/custom.nss)
- Stock/default modifications: [`nss files/imports/modify.nss`](./nss%20files/imports/modify.nss)
- File management submenu: [`nss files/imports/file-manage.nss`](./nss%20files/imports/file-manage.nss)

Official references:

- [Nilesoft docs](https://nilesoft.org/docs)
- [Configuration](https://nilesoft.org/docs/configuration)
- [New items](https://nilesoft.org/docs/configuration/new-items)
- [Modify items](https://nilesoft.org/docs/configuration/modify-items)
- [Properties](https://nilesoft.org/docs/configuration/properties)
- [Key functions](https://nilesoft.org/docs/functions/key)
- [Path functions](https://nilesoft.org/docs/functions/path)

Key upstream/community threads:

- [moudey/Shell issue #308](https://github.com/moudey/Shell/issues/308) - moving third-party DLL-backed handlers by title.
- [moudey/Shell discussion #578](https://github.com/moudey/Shell/discussions/578) - moving items into custom and nested menus with `menu=`.
- [moudey/Shell issue #635](https://github.com/moudey/Shell/issues/635) - empty menu visibility and `item(vis=0)` anchor pattern.
- [moudey/Shell issue #756](https://github.com/moudey/Shell/issues/756) - an item cannot practically live in two places.
- [moudey/Shell issue #347](https://github.com/moudey/Shell/issues/347) - disabled third-party handler fixed with `vis=true`.

## 1. Architecture And Mental Model

Nilesoft Shell builds the classic Windows context menu from two kinds of declarations:

- New dynamic items: `menu(...) { ... }`, `item(...)`, `separator(...)`, and `import ...` blocks that create new Shell-owned UI.
- Modification rules: `modify(...)` and `remove(...)` rules that target existing Windows, system, or third-party shell items.

Think of rendering as a pipeline:

1. Shell loads `shell.nss`.
2. `settings { ... }` defines global behavior.
3. Imports are expanded in order.
4. New menus/items are evaluated for the current context using `type`, `mode`, `where`, and visibility properties.
5. `modify()` and `remove()` rules target items that exist in the evaluated menu tree.
6. The final visible menu is shown, with hidden/removed items and duplicate cleanup applied.

The most important implication: a `modify(... menu='Target')` move can only land in a destination menu that exists in the evaluated tree for that invocation. If a destination menu is blocked by `where=false`, it is not a valid move target at that time.

## 2. This Repo's Load Order

`nss files/shell.nss` is the entry point. The current structure is:

```nss
settings
{
	priority=1
	exclude.where = !process.is_explorer
	showdelay = 200
	modify.remove.duplicate=1
	tip.enabled=true
}

import 'imports/theme.nss'
import 'imports/images.nss'

menu(mode="multiple" title="Pin/Unpin" image=icon.pin)
{
}

menu(mode="multiple" title=title.more_options image=icon.more_options)
{
}

import '...\imports\modify.nss'
import '...\imports\file-manage.nss'
import '...\imports\taskbar.nss'
import '...\imports\custom.nss'
import '...\imports\recycle.bin.nss'
import '...\imports\my-goto.nss'
```

Why this matters:

- `theme.nss` and `images.nss` must load before menus use shared colors/icons.
- Empty anchor menus like `Pin/Unpin` and `More options` are declared before `modify.nss` and `custom.nss` move items into them.
- `file-manage.nss` must load before `custom.nss`, because `custom.nss` moves items into `File manage`.
- `custom.nss` is the repo-specific customization layer. Keep personal layout changes there unless they are general stock cleanup.

## 3. Static Vs Dynamic Items

Older community examples sometimes refer to "static" shell entries or use older-looking blocks. In current Nilesoft docs, the useful split is:

- New items: Shell-created `menu`, `item`, and `separator` declarations.
- Modify items: `modify()` rules that edit, move, hide, or remove items created by Windows or shell extensions.

Third-party shell handlers, including Visual Studio, NanaZip, WinRAR, TeraCopy, FastStone, Notepad++, Autodesk Inventor, and similar extensions are not usually declared in NSS. They appear as existing items in the menu tree. You target them with `modify()` or `remove()` using title matching, IDs, source submenu filters, type filters, and conditions.

## 4. `modify()` Deep Dive

`modify()` is the tool for changing existing menu entries. It can target by visible text, internal ID, current submenu, type, mode, and conditions.

Common pattern:

```nss
modify(
	type='dir|back.dir|drive|back.drive|desktop'
	where=key.shift()
	find='Open with Visual Studio*|Open in Visual Studio*'
	menu='Open in...'
	pos='bottom'
)
```

### `find`

`find` matches the displayed title text of existing menu entries.

```nss
modify(find='NanaZip' menu='Archiving Tools')
modify(find='Open with Visual Studio*|Open in Visual Studio*' menu='Open in...')
remove(find='Add to Windows Media Player Legacy list')
```

Rules of thumb:

- `*` is useful for prefix/suffix variation.
- `|` matches alternatives in one rule.
- Match the actual UI text, not a guessed registry key.
- If a move fails, test `remove(find='Exact title')` temporarily to prove the title match.

### `in`

`in=` is a source submenu filter. It does not define the destination.

Use it when the existing item is already inside another submenu:

```nss
menu(title='Microsoft' menu='Nuovo') {}
menu(title='Google' menu='Nuovo') {}

modify(find='Microsoft|Rich' in='/Nuovo' menu='/Nuovo/Microsoft')
modify(find='Google' in='/Nuovo' menu='/Nuovo/Google')
```

Do not confuse this with:

```nss
modify(find='Item' in='Destination') // wrong mental model
```

That means "find Item inside submenu Destination", not "move Item to Destination".

### `menu` / `parent`

`menu=` is the destination menu for a move. Docs group this under the Parent/Menu property. Community examples overwhelmingly use `menu=`.

```nss
menu(mode='multiple' title='Scan with') {}
modify(mode='multiple' find='VirusTotal|Microsoft Defender|Malwarebytes' pos=2 menu='Scan with')
```

Nested destination path:

```nss
menu(mode='multiple' title='Antivirus' menu=title.more_options) {}
modify(mode='multiple' find='Microsoft Defender' menu='@title.more_options/Antivirus')
```

Use `/` to address nested paths. Use `@title.more_options` when referencing a localized built-in title constant as part of a string path.

### `pos`

`pos` changes ordering. Common values:

```nss
pos='top'
pos='bottom'
pos=1
pos=2
```

Caveat: integer `pos` values can be unreliable when separators, Windows-provided dynamic groups, and extension handlers are involved. Prefer `top`/`bottom` unless exact ordering is necessary.

### `sep`

`sep` adds separators around a modified item.

```nss
modify(find='Design Assistant' sep=sep.after pos=pos.bottom menu=title.more_options)
modify(type='recyclebin' where=window.is_desktop and this.id==id.empty_recycle_bin pos=1 sep)
```

Depending on local style, examples use `sep`, `sep='top'`, `sep=sep.after`, or `separator='before'` on new items. Avoid mixing styles in one block unless copying an upstream snippet.

### `vis`

`vis` controls visibility state. It can hide, show, remove, or label entries depending on value.

Examples:

```nss
modify(find='Notepad' vis='true')
modify(find='7-Zip' type='drive' vis='hidden')
modify(where=this.id(id.restore_previous_versions,id.cast_to_device) vis=vis.remove)
item(title='Created' keys=io.dt.created(sel.path, 'y/m/d') vis=label)
```

Important values/patterns:

- `vis=key.shift()` shows only while Shift is held.
- `vis='hidden'` hides without necessarily deleting from processing.
- `vis=vis.remove` removes from the final menu.
- `vis=true` can force-enable/show a disabled third-party handler in some cases, as in issue #347.
- `item(vis=0)` creates an invisible anchor item inside a menu.

### `where`

`where` decides whether the rule itself is processed. If false, the rule or menu declaration is skipped.

```nss
modify(where=this.id==id.copy_as_path vis=vis.remove)
item(where=package.exists('WindowsTerminal') title=title.Windows_Terminal ...)
menu(where=sel.count>0 type='file|dir|drive|namespace|back' title='File manage') { ... }
```

This is powerful and dangerous. Do not put `where=key.shift()` on a destination menu that must receive moved items. Use `vis=key.shift()` for destination menu visibility.

### `type`

`type` scopes a rule to selected object kinds.

Examples from this repo:

```nss
menu(type='dir|back.dir|drive|back.drive|desktop' title='Open in...')
remove(type='taskbar' find=title.desktop)
item(type='file|dir|back.dir|drive' title='Take ownership' admin ...)
```

Use `type=` on `modify()`/`remove()` when:

- The same title appears in multiple context types.
- You only want to affect directories, drives, desktop background, taskbar, Recycle Bin, etc.
- A broad `find=` rule removes too much.

Avoid `type=` when you are still discovering whether a match works. First prove title matching with a broad temporary `remove(find='...')`, then add scope.

### `mode`

`mode` controls single vs multiple selection behavior.

```nss
menu(mode='multiple' title='Archiving Tools' image=\uE0AA) {}
modify(mode=mode.multiple find='NanaZip' menu='Archiving Tools')
item(mode='single' type='file' title='Change extension' ...)
```

Use `mode='multiple'` on destination menus that should appear for multi-select, especially when moving archive tools or pin/unpin entries.

### `id.*` Targeting

IDs are more robust than title text when Nilesoft exposes a known system item:

```nss
remove(where=this.id==id.copy_as_path)

modify(mode=mode.multiple
	where=this.id(
		id.send_to,
		id.share,
		id.create_shortcut,
		id.print
	)
	pos=1
	menu=title.more_options)
```

Use IDs for Windows-known items. Use `find` for third-party handlers whose IDs are not known or exposed.

## 5. Process, Validation, And Filter Properties

It helps to classify properties by when they act:

| Property | Role | Mental model |
| --- | --- | --- |
| `where` | Processing condition | If false, this declaration/rule is skipped. |
| `type` | Context filter | Only applies to selected object kinds. |
| `mode` | Selection-count filter | Single, multiple, or both. |
| `find` | Target matcher | Finds existing entries by title text. |
| `in` | Source filter | Narrows existing targets by current submenu. |
| `menu` / `parent` | Destination | Moves a target into an existing/evaluated menu. |
| `vis` | Final visibility | Hides, shows, labels, or removes after evaluation. |
| `pos` | Ordering | Places an item relative to siblings. |
| `sep` / `separator` | Decoration | Adds separators before/after/around items. |

The biggest distinction is `where` vs `vis`:

- `where=false` means "this thing does not participate."
- `vis=false` or `vis=key.shift()` means "this thing can exist but may not be visible."

## 6. `remove()` And `vis=vis.remove`

`remove()` is shorthand for removing existing items. In practice:

```nss
remove(find='Add to Favorites')
```

is conceptually equivalent to:

```nss
modify(find='Add to Favorites' vis=vis.remove)
```

Use `remove()` when the intent is simple deletion:

```nss
remove(find='Browse with FastStone')
remove(type='taskbar' find=title.desktop)
```

Use `modify(... vis=vis.remove)` when you are already targeting by complex `where=this.id(...)` or combining removal with other modification syntax:

```nss
modify(mode=mode.multiple
	where=this.id(id.restore_previous_versions,id.cast_to_device)
	vis=vis.remove)
```

Use conditional `remove()` to hide a native item in one state while moving it in another:

```nss
modify(where=key.shift() find='Open with Visual Studio*|Open in Visual Studio*' menu='Open in...' pos='bottom')
remove(where=!key.shift() find='Open with Visual Studio*|Open in Visual Studio*')
```

## 7. Menu Patterns

### Empty Anchor Menu

Create the menu first, move things into it later:

```nss
menu(mode='multiple' title='Archiving Tools' image=\uE0AA) {}

modify(mode=mode.multiple find='NanaZip' menu='Archiving Tools')
modify(mode=mode.multiple find='7-Zip' menu='Archiving Tools')
modify(mode=mode.multiple find='WinRAR' menu='Archiving Tools')
modify(mode=mode.multiple find='Extract All...' menu='Archiving Tools')
```

This is used in this repo's `custom.nss`.

### Filled Menu

Create custom items directly inside a menu:

```nss
menu(title='Open in...'
	type='dir|back.dir|drive|back.drive|desktop'
	vis=key.shift()
	where=(sel.count <= 1)
	image=\uE0AB)
{
	item(title='Search with Everything'
		image='C:\Program Files\Everything 1.5a\Everything.exe'
		cmd='C:\Program Files\Everything 1.5a\Everything.exe'
		args='-search "@sel.path "')

	separator()

	item(title='Cursor' image=\uE17A cmd='cursor' args='"@sel.path"' window=cmd.hidden)
}
```

### Nested Menu

Declare child menu inside a parent block:

```nss
menu(title='File manage')
{
	menu(title='Show/Hide' image=icon.show_hidden_files)
	{
		item(title='System files' image=inherit cmd='@command.togglehidden')
		item(title='File name extensions' image=icon.show_file_extensions cmd='@command.toggleext')
	}
}
```

Or attach a child by property:

```nss
menu(title='Antivirus' menu=title.more_options) {}
modify(find='Microsoft Defender' menu='@title.more_options/Antivirus')
```

### Import Inside Menu

This repo's `file-manage.nss` imports PowerShell command links inside the `File manage` menu:

```nss
menu(where=sel.count>0 type='file|dir|drive|namespace|back' mode='multiple' title='File manage' image=\uE253)
{
	separator()
	import 'commands.links.ps.nss'
}
```

That imported file contributes items inside the current menu scope.

## 8. Critical: `where` Vs `vis`

This is the most expensive lesson from the research.

Bad pattern for a destination menu:

```nss
menu(title='Open in...'
	type='dir|back.dir|drive|back.drive|desktop'
	where=(key.shift() and sel.count <= 1)
	image=\uE0AB)
{
	item(title='Cursor' cmd='cursor' args='"@sel.path"')
}

modify(find='Open with Visual Studio*' menu='Open in...')
```

Why it fails:

- `where=key.shift()` controls whether the `Open in...` declaration is processed.
- When Shift is not held, the menu does not exist in the evaluated tree.
- `modify(... menu='Open in...')` needs a destination menu that exists.
- If the target item appears at a different point in Shell's evaluation than the shift-gated menu, the move cannot land reliably.

Correct pattern:

```nss
menu(title='Open in...'
	type='dir|back.dir|drive|back.drive|desktop'
	vis=key.shift()
	where=(sel.count <= 1)
	image=\uE0AB)
{
	item(title='Cursor' cmd='cursor' args='"@sel.path"')
}

modify(
	type='dir|back.dir|drive|back.drive|desktop'
	where=key.shift()
	find='Open with Visual Studio*|Open in Visual Studio*'
	menu='Open in...'
	pos='bottom'
)

remove(
	type='dir|back.dir|drive|back.drive|desktop'
	where=!key.shift()
	find='Open with Visual Studio*|Open in Visual Studio*'
)
```

Why this works:

- The destination menu declaration is evaluated for the relevant context.
- `vis=key.shift()` hides the menu normally but keeps it as a valid move target.
- The move only happens while Shift is held.
- The native root item is removed when Shift is not held.

## 9. Ghost Duplicate Menus

Never declare two menu blocks with the same title and expect Nilesoft to merge them.

Bad:

```nss
menu(title='Open in...') { item(title='Cursor') }
menu(title='Open in...') { item(title='Visual Studio') }
```

Nilesoft does not treat same-title menu declarations as one logical menu. You can create duplicate or ghost menus, and `modify(... menu='Open in...')` may target the wrong one or fail unpredictably.

Correct:

```nss
menu(title='Open in...')
{
	item(title='Cursor')
	item(title='Visual Studio')
}
```

Or one anchor declaration plus external `modify()` rules:

```nss
menu(mode='multiple' title='Archiving Tools') {}
modify(find='NanaZip|7-Zip|WinRAR' menu='Archiving Tools')
```

## 10. Empty Menu Visibility And `item(vis=0)`

Issue #635 established a practical pattern: empty custom menus may not display. If you need a menu to exist visibly or act as a stable anchor before moved items land, place an invisible item inside it.

```nss
menu(mode='multiple' title='Prova1' image=\uE1E8)
{
	item(vis=0)
}
```

Use this sparingly:

- Good for debugging whether the destination menu exists.
- Good for a menu that will otherwise be empty until third-party handlers appear.
- Not needed for a filled menu like this repo's `Open in...`, because it already contains custom items.

## 11. Nested Menu Paths

Use `/` to refer to nested menu destinations:

```nss
menu(title='Antivirus' menu=title.more_options) {}
modify(find='Microsoft Defender' menu='@title.more_options/Antivirus')
```

For an item inside an existing submenu, combine `in=` and `menu=`:

```nss
menu(title='Microsoft' menu='Nuovo') {}
modify(find='Microsoft|Rich' in='/Nuovo' menu='/Nuovo/Microsoft')
```

Rules:

- `menu='/Parent/Child'` is destination path.
- `in='/Parent'` is source path.
- If using constants in paths, prefix with `@` inside strings, e.g. `@title.more_options/Submenu`.

## 12. Moving Third-Party Shell Handlers

GitHub issue #308 showed third-party DLL-backed shell items can be moved by visible title even when they are not easy to find in registry text searches.

Working examples:

```nss
modify(find='Design Assistant' sep=sep.after pos=pos.bottom menu=title.more_options)
modify(find='Pack and Go|iProperties|Purge*' pos=pos.bottom menu=title.more_options)
```

This repo uses the same idea:

```nss
modify(find='TeraCopy*' pos='bottom' menu='File manage')
modify(mode=mode.multiple find='NanaZip' menu='Archiving Tools')
modify(mode=mode.multiple find='7-Zip' menu='Archiving Tools')
modify(mode=mode.multiple find='WinRAR' menu='Archiving Tools')
modify(find='Blip' menu='More options')
```

For Visual Studio:

```nss
modify(
	type='dir|back.dir|drive|back.drive|desktop'
	where=key.shift()
	find='Open with Visual Studio*|Open in Visual Studio*'
	menu='Open in...'
	pos='bottom'
)
```

If it does not move:

1. Temporarily try `remove(find='Open with Visual Studio*|Open in Visual Studio*')`.
2. If removal works, title matching is correct and the destination/timing is the issue.
3. If removal fails, the title, type scope, source submenu, or shell extension registration is wrong.
4. If it exists under another submenu, add `in='...'`.
5. If it is disabled/greyed out, try `modify(find='Open with Visual Studio*' vis=true)` or recreate it as a custom item only if necessary.

## 13. Items Cannot Exist In Two Places

Issue #756 surfaced an important limitation: do not try to keep the same existing item in two destinations. A moved item is re-parented; another rule trying to sort, move, or show the original elsewhere can conflict.

Bad:

```nss
modify(find='Open with Visual Studio*' menu='More options')
modify(find='Open with Visual Studio*' menu='Open in...')
```

Correct:

```nss
modify(where=key.shift() find='Open with Visual Studio*' menu='Open in...')
remove(where=!key.shift() find='Open with Visual Studio*')
```

If you need the same behavior in two places, create one native moved item and one custom `item(...)` that invokes the command. Do not expect one native shell item to be cloned.

## 14. Shift And Ctrl Conditional Patterns

Use `key.shift()` and `key.control()` consistently in new code. Some older snippets use `keys.shift()`, but this repo already uses `key.shift()` in working patterns.

Custom menu visible only with Shift:

```nss
menu(title='Advanced' vis=key.shift())
{
	item(title='Restart Explorer' cmd=command.restart_explorer)
}
```

Item visible only with Ctrl+Shift:

```nss
item(title='Restart Explorer'
	vis=key.control() and key.shift()
	cmd=command.restart_explorer)
```

Existing item hidden unless Shift is held:

```nss
modify(find='Target Item' vis=key.shift())
```

Shift-gated move:

```nss
modify(where=key.shift() find='Target Item' menu='Advanced')
remove(where=!key.shift() find='Target Item')
```

Use `vis` on destination menus. Use `where` on move/remove rules.

## 15. Invalid Or Dangerous Syntax

These patterns have caused crashes, no-ops, or confusing behavior:

| Anti-pattern | Why it is bad | Use instead |
| --- | --- | --- |
| Root-level `item(menu='Open in...')` | New `item()` declarations belong inside menu blocks or at valid root scope without using `menu=` as an afterthought. Some invalid root-level destination attempts can crash Shell. | Put custom items inside the actual `menu { ... }` block. |
| Two `menu(title='Same')` blocks | Shell does not merge them; duplicate or ghost menus can appear. | One menu block, or one anchor plus `modify()` rules. |
| `where=key.shift()` on destination menu | The menu is not evaluated when Shift is not held, so it may not be a stable move target. | `vis=key.shift()` on the menu, `where=key.shift()` on the move rule. |
| Duplicate `where=` properties in one declaration | Later values may override or syntax may fail. | Combine with `and` / `or`: `where=key.shift() and sel.count <= 1`. |
| Variables inside `type=` | `type` expects valid type tokens, not arbitrary variables. | Use literal type strings like `type='file|dir|drive'`. |
| `modify()` inside a `menu {}` block | `modify()` rules are not normal child items. | Put `modify()` at top/import scope after the destination menu exists. |
| `in=` as destination | `in` filters source submenu. | Use `menu=` for destination. |
| Moving one native item to two menus | Existing items are re-parented, not cloned. | Pick one destination or create a separate custom item. |
| Hardcoding app paths for everyone | Breaks on machines without that install path. | Prefer native shell item move, or guard with `path.exists(...)` / `package.exists(...)`. |
| Over-specific `type=` during discovery | Can hide valid matches and mislead debugging. | First prove `find`, then add `type` scope. |

## 16. Working Patterns In This Repo

### More Options

`shell.nss` creates a shared `More options` anchor:

```nss
menu(mode='multiple' title=title.more_options image=icon.more_options)
{
}
```

`modify.nss` moves known built-in IDs into it:

```nss
modify(mode=mode.multiple
	where=this.id(
		id.send_to,
		id.share,
		id.create_shortcut,
		id.print
	)
	pos=1
	menu=title.more_options)
```

`custom.nss` moves extra third-party/noisy entries into it:

```nss
modify(find='Scan with Microsoft Defender' menu='More options')
modify(find='Blip' menu='More options')
modify(find='Move to OneDrive' menu='More options')
modify(find='Troubleshoot compatibility' menu='More options')
```

### Archiving Tools

```nss
menu(mode='multiple' title='Archiving Tools' image=\uE0AA) { }

modify(mode=mode.multiple find='NanaZip' menu='Archiving Tools')
modify(mode=mode.multiple find='7-Zip' menu='Archiving Tools')
modify(mode=mode.multiple find='WinRAR' menu='Archiving Tools')
modify(mode=mode.multiple find='Extract All...' menu='Archiving Tools')
```

### File Manage

`file-manage.nss` declares a rich destination menu:

```nss
menu(where=sel.count>0 type='file|dir|drive|namespace|back' mode='multiple' title='File manage' image=\uE253)
{
	menu(separator='after' title=title.copy_path image=icon.copy_path)
	{
		item(where=sel.count > 1 title='Copy (@sel.count) items selected' cmd=command.copy(sel(false, '\n')))
		item(mode='single' title=@sel.path tip=sel.path cmd=command.copy(sel.path))
	}

	item(type='file|dir|back.dir|drive' title='Take ownership' image=[\uE194,#f00] admin ...)

	separator()
	import 'commands.links.ps.nss'
}
```

`custom.nss` moves items into it after it exists:

```nss
modify(find='New folder with selection' menu='File manage' image=icon.new_folder)
modify(find='TeraCopy*' pos='bottom' menu='File manage')
```

### Pin/Unpin

```nss
menu(mode='multiple' title='Pin/Unpin' image=icon.pin)
{
}

modify(find='unpin*' pos='bottom' menu='Pin/Unpin')
modify(find='pin*' pos='top' menu='Pin/Unpin')
```

### Open In

The repo's important Shift-only launch menu:

```nss
menu(title='Open in...'
	type='dir|back.dir|drive|back.drive|desktop'
	vis=key.shift()
	where=(sel.count <= 1)
	image=\uE0AB)
{
	item(title='Search with Everything'
		image='C:\Program Files\Everything 1.5a\Everything.exe'
		cmd='C:\Program Files\Everything 1.5a\Everything.exe'
		args='-search "@sel.path "')

	separator()

	$tip_run_admin=['\xE1A7 Press SHIFT key to run ' + this.title + ' as administrator', tip.warning, 1.0]
	$has_admin=key.shift() or key.rbutton()

	item(title=title.command_prompt tip=tip_run_admin admin=has_admin image cmd='cmd.exe' args='/K TITLE Command Prompt &ver& PUSHD "@sel.dir"')
	item(title=title.windows_powershell admin=has_admin tip=tip_run_admin image cmd='powershell.exe' args='-noexit -command Set-Location -Path "@sel.dir\."')
	item(where=package.exists('WindowsTerminal') title=title.Windows_Terminal tip=tip_run_admin admin=has_admin image='@package.path("WindowsTerminal")\WindowsTerminal.exe' cmd='wt.exe' arg='-d "@sel.path\."')

	separator()

	item(title='VSCodium' image=[\uE272, #2FA0CE] cmd='codium' args='"@sel.path"' window=cmd.hidden)
	item(title='Cursor' image=\uE17A cmd='cursor' args='"@sel.path"' window=cmd.hidden)
}
```

Native Visual Studio move pattern:

```nss
modify(type='dir|back.dir|drive|back.drive|desktop' where=key.shift() find='Open with Visual Studio*|Open in Visual Studio*' menu='Open in...' pos='bottom')
remove(type='dir|back.dir|drive|back.drive|desktop' where=!key.shift() find='Open with Visual Studio*|Open in Visual Studio*')
```

### System Maintenance

Recycle Bin-specific menu:

```nss
menu(title='System Maintenance' sep='top' image=\uE0F3 where=sel.raw=='::{645FF040-5081-101B-9F08-00AA002F954E}')
{
	item(title='Flush DNS Cache'
		admin image=\uE14B
		cmd-line='/c ipconfig /flushdns & echo DNS cache flushed successfully! & timeout /t 2 >nul')
}
```

## 17. Expressions And Variables

NSS expressions are powerful enough to avoid brittle hardcoding.

Variables:

```nss
$tip_run_admin=['\xE1A7 Press SHIFT key to run ' + this.title + ' as administrator', tip.warning, 1.0]
$has_admin=key.shift() or key.rbutton()

item(title=title.command_prompt tip=tip_run_admin admin=has_admin ...)
```

Package checks:

```nss
item(where=package.exists('WindowsTerminal')
	title=title.Windows_Terminal
	image='@package.path("WindowsTerminal")\WindowsTerminal.exe'
	cmd='wt.exe'
	arg='-d "@sel.path\."')
```

Path checks:

```nss
$vs_devenv='C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\devenv.exe'

item(where=path.exists(vs_devenv)
	title='Open with Visual Studio'
	image=vs_devenv
	cmd=vs_devenv
	args='"@sel.path"')
```

Prefer the native shell item move for Visual Studio when possible. Use a `path.exists(...)` fallback only when the native item cannot be moved or does not register on a target machine.

Selection expressions:

```nss
where=sel.count>0
where=(sel.count <= 1)
title=@sel.path
cmd=command.copy(sel.path)
args='"@sel.path"'
```

Key expressions:

```nss
vis=key.shift()
where=!key.shift()
vis=key.control() and key.shift()
admin=key.shift() or key.rbutton()
```

Command helpers:

```nss
cmd=command.copy(sel.path)
cmd=command.folder_options
cmd=command.restart_explorer
cmd='@command.togglehidden'
cmd='@command.toggleext'
```

## 18. Debugging Playbook

### Reload Methods

- Ctrl + right-click desktop or taskbar to reload Shell.
- Shift + right-click taskbar -> Shell -> Directory opens the install/config folder.
- Restart Explorer if reload does not pick up changes.

### Log Location

Check:

```text
C:\Program Files\Nilesoft Shell\shell.log
```

If the menu fails to load, start there. Syntax errors can prevent the whole config from rendering.

### Minimal Debug Loop

When moving an item fails:

1. Prove the target exists:

```nss
remove(find='Open with Visual Studio*|Open in Visual Studio*')
```

2. If removal works, restore it and prove the destination menu exists:

```nss
menu(title='Open in...' vis=key.shift())
{
	item(vis=0)
}
```

3. Add the move without extra scope:

```nss
modify(find='Open with Visual Studio*|Open in Visual Studio*' menu='Open in...')
```

4. Add `where`, `type`, and `pos` only after the basic move works.

5. If the item lives under another submenu, add `in=`.

6. If the item is disabled, try:

```nss
modify(find='Open with Visual Studio*' vis=true)
```

7. If native movement is impossible, recreate as guarded custom `item(...)`.

## 19. Edge Cases And Limitations

### Windows 11 Modern Menu

Nilesoft Shell primarily controls the classic context menu surface. It cannot modify every Windows 11 modern context menu entry directly. If an entry only exists in the modern compact menu and not in the classic shell tree, `modify()` may not see it.

### Disabled Third-Party Handlers

Issue #347 showed a disabled Notepad++ handler fixed with:

```nss
modify(find='Notepad' vis=true)
```

If invoking still fails, the extension itself may be broken. Remove it and create a custom command item as a fallback.

### DLL-Backed Handlers

Third-party context items may be implemented by DLLs and not obvious in registry search. Match by visible title with `find`, use wildcards, and confirm with temporary `remove()`.

### Positioning

`pos=1` and `pos=2` can shift unexpectedly because separators and dynamic Windows groups count. Prefer `pos='top'` or `pos='bottom'`.

### Localization

Title matching is language-dependent. If a Windows system item is localized, prefer `this.id==id.*` or `str.res(...)` patterns when available.

### Import Order

If `modify(... menu='File manage')` runs before `File manage` is declared, the move can fail. Put destination menus earlier in `shell.nss` or in an earlier import.

## 20. Decision Flowchart: Move Item X Into Submenu Y

Use this checklist whenever moving an existing context menu entry.

1. Is X a custom item you created?

If yes, put it directly inside `menu(title='Y') { ... }`. Do not use `modify()`.

2. Is X an existing Windows or third-party item?

Use `modify()` or `remove()`.

3. Does Y exist before the `modify()` rule runs?

If no, declare it earlier.

```nss
menu(title='Y') {}
modify(find='X' menu='Y')
```

4. Is Y conditionally gated with `where`?

If yes, change destination visibility to `vis=...` and keep `where` only for stable context filters.

```nss
menu(title='Y' vis=key.shift() where=sel.count <= 1) {}
modify(where=key.shift() find='X' menu='Y')
```

5. Does X actually match?

Temporarily test:

```nss
remove(find='X*')
```

6. Is X inside another submenu?

Add `in=`.

```nss
modify(find='X' in='/Existing Parent' menu='Y')
```

7. Is X already moved elsewhere?

Remove the conflicting move. One native item cannot live in two places.

8. Is X disabled?

Try:

```nss
modify(find='X*' vis=true)
```

9. Is exact ordering failing?

Use `pos='bottom'` first. Integer positions are not stable enough for early debugging.

10. Still failing?

Use a guarded custom fallback item:

```nss
item(where=path.exists('C:\Path\Tool.exe') title='X' cmd='C:\Path\Tool.exe' args='"@sel.path"')
```

## 21. Anti-Patterns Table

| Want | Do not do this | Correct pattern |
| --- | --- | --- |
| Shift-only submenu that receives moved items | `menu(where=key.shift() title='Open in...')` | `menu(vis=key.shift() title='Open in...')` |
| Add another item to same submenu | Declare another `menu(title='Open in...')` | Add item to the existing block |
| Move native item into submenu | Custom `item(menu='Submenu')` at root | `modify(find='Native Item' menu='Submenu')` |
| Move item from existing submenu | `modify(find='X' menu='Y')` only | `modify(find='X' in='/Old' menu='Y')` |
| Keep item in root and submenu | Two `modify()` destinations | Move once, or create a custom clone |
| Match third-party handler by registry path | Search registry and hardcode CLSID | Match visible title with `find` |
| Hide native item normally | Unconditional `remove(find='X')` | `remove(where=!key.shift() find='X')` |
| Debug a failed move | Add more `type` and `pos` | First test `remove(find='X')` |
| Force exact integer position | `pos=2` everywhere | Use `pos='top'` / `pos='bottom'` unless proven |
| Fix disabled handler | Recreate immediately | Try `modify(find='X' vis=true)` first |

## 22. Reference Snippets

### Create A Destination Menu And Move Items Into It

```nss
menu(mode='multiple' title='Tools' image=\uE0AA) {}

modify(mode=mode.multiple find='Tool A|Tool B|Tool C' menu='Tools' pos='bottom')
```

### Move Visual Studio Into Shift-Only Open In

```nss
menu(title='Open in...'
	type='dir|back.dir|drive|back.drive|desktop'
	vis=key.shift()
	where=(sel.count <= 1)
	image=\uE0AB)
{
	item(title='Cursor' image=\uE17A cmd='cursor' args='"@sel.path"' window=cmd.hidden)
}

modify(type='dir|back.dir|drive|back.drive|desktop'
	where=key.shift()
	find='Open with Visual Studio*|Open in Visual Studio*'
	menu='Open in...'
	pos='bottom')

remove(type='dir|back.dir|drive|back.drive|desktop'
	where=!key.shift()
	find='Open with Visual Studio*|Open in Visual Studio*')
```

### Empty Anchor Menu

```nss
menu(mode='multiple' title='My Anchor' image=\uE1E8)
{
	item(vis=0)
}
```

### Nested Destination Under More Options

```nss
menu(mode='multiple' title='Antivirus' image=\uE1E8 menu=title.more_options) {}

modify(mode=mode.multiple
	find='VirusTotal|Microsoft Defender|Malwarebytes'
	menu='@title.more_options/Antivirus')
```

### Move From Existing Submenu To New Nested Submenu

```nss
menu(title='Microsoft' menu='Nuovo') {}

modify(find='Microsoft|Rich'
	in='/Nuovo'
	menu='/Nuovo/Microsoft')
```

### Force-Show Disabled Third-Party Handler

```nss
modify(find='Notepad' vis=true)
```

### Remove Clutter

```nss
remove(find='Add to Windows Media Player Legacy list')
remove(find='Play with Windows Media Player Legacy')
remove(find='Add to Favorites')
remove(find='Browse with FastStone')
```

### Move Known System IDs To More Options

```nss
modify(mode=mode.multiple
	where=this.id(
		id.send_to,
		id.share,
		id.create_shortcut,
		id.set_as_desktop_background,
		id.rotate_left,
		id.rotate_right,
		id.map_network_drive,
		id.disconnect_network_drive,
		id.format,
		id.eject,
		id.give_access_to,
		id.include_in_library,
		id.print
	)
	pos=1
	menu=title.more_options)
```

### Guard A Custom Item By Installed Path

```nss
$tool='C:\Program Files\Some Tool\tool.exe'

item(where=path.exists(tool)
	title='Open with Some Tool'
	image=tool
	cmd=tool
	args='"@sel.path"'
	window=cmd.hidden)
```

### Guard A Custom Item By Package

```nss
item(where=package.exists('WindowsTerminal')
	title=title.Windows_Terminal
	image='@package.path("WindowsTerminal")\WindowsTerminal.exe'
	cmd='wt.exe'
	arg='-d "@sel.path\."')
```

### Confirm A Title Match

```nss
// Temporary debugging only.
remove(find='Open with Visual Studio*|Open in Visual Studio*')
```

If the item disappears, `find` works. Undo the temporary remove and debug destination/timing.

## 23. Final Rules Of Thumb

- Declare destination menus before moving items into them.
- Use `vis`, not `where`, for Shift-only destination menu visibility.
- Put `modify()` rules outside menu blocks.
- Use `menu=` for destination and `in=` for source.
- Never duplicate a same-title menu block and expect merging.
- Prefer native item movement over hardcoded app paths.
- Guard fallback custom app items with `path.exists()` or `package.exists()`.
- Use `item(vis=0)` only when an empty menu needs an anchor.
- Do not try to place one native item in two menus.
- Debug in this order: title match, destination existence, source submenu, type scope, visibility, position.
