// // // // // Remove the two Windows Media Player Legacy options and extra useless things

remove(find="Add to Windows Media Player Legacy list")
remove(find="Play with Windows Media Player Legacy")

remove(find="Add to Favorites")
remove(find="Browse with FastStone") 



// // // // // Move "New folder with selection" into the "File manage" group

modify(find="New folder with selection" menu="File manage" image=icon.new_folder)
modify(find="TeraCopy*" pos="bottom" menu="File manage")
modify(find="File Converter*" menu="File manage")

// // // // // GROUPING Archiving Tools

// Create a new sub-menu (mode=multiple so it appears for multi-select too)
menu(mode="multiple" title="Archiving Tools" image=\uE0AA) { }

// Move existing third-party items into that sub-menu
modify(mode=mode.multiple find="NanaZip" menu="Archiving Tools")
modify(mode=mode.multiple find="7-Zip" menu="Archiving Tools")
modify(mode=mode.multiple find="WinRAR" menu="Archiving Tools")
modify(mode=mode.multiple find="Extract All..." menu="Archiving Tools")



// // // // // // MOVING to More Options

modify(find="Scan with Microsoft Defender" menu="More options")
modify(find="Blip" menu="More options")
modify(find="Move to OneDrive" menu="More options")
modify(find="Troubleshoot compatibility" menu="More options")


// // // // // // LAUNCH MENU (Requires holding SHIFT to appear)

menu(title='Open in...'
	type='dir|back.dir|drive|back.drive|desktop'
	vis=key.shift()
	where=(sel.count <= 1)
	image=\uE0AB)
{
	// 1. Search
	item(title='Search with Everything'
		image='C:\Program Files\Everything 1.5a\Everything.exe'
		cmd='C:\Program Files\Everything 1.5a\Everything.exe'
		args='-search "@sel.path "')

	item(title='Open in EzShare'
		image=\uE26B
		cmd='ezshare'
		args='"@sel.dir"')

	separator()

	// 2. Terminals
	$tip_run_admin=["\xE1A7 Press SHIFT key to run " + this.title + " as administrator", tip.warning, 1.0]
	$has_admin=key.shift() or key.rbutton()

	item(title=title.command_prompt tip=tip_run_admin admin=has_admin image cmd='cmd.exe' args='/K TITLE Command Prompt &ver& PUSHD "@sel.dir"')
	item(title=title.windows_powershell admin=has_admin tip=tip_run_admin image cmd='powershell.exe' args='-noexit -command Set-Location -Path "@sel.dir\."')
	item(where=package.exists("WindowsTerminal") title=title.Windows_Terminal tip=tip_run_admin admin=has_admin image='@package.path("WindowsTerminal")\WindowsTerminal.exe' cmd='wt.exe' arg='-d "@sel.path\."')

	separator()

	// 3. Code Editors 
	item(title='VSCodium' image=[\uE272, #2FA0CE] cmd='codium' args='"@sel.path"' window=cmd.hidden)
	item(title='Cursor' image=\uE17A cmd='cursor' args='"@sel.path"' window=cmd.hidden)

	$vs_devenv='C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\devenv.exe'
	item(where=path.exists(vs_devenv) title='Open with Visual Studio' image=vs_devenv cmd=vs_devenv args='"@sel.path"')
}

// Added manually in open in option.
remove(find="Open with Visual Studio*")


// // // // RECYCLE BIN THINGS

menu(title='System Maintenance' sep='top' image=\uE0F3 where=sel.raw=='::{645FF040-5081-101B-9F08-00AA002F954E}')
{
	// 1. Flush DNS (Shows a brief command prompt window to confirm success)
	item(title='Flush DNS Cache' 
		admin image=\uE14B 
		cmd-line='/c ipconfig /flushdns & echo DNS cache flushed successfully! & timeout /t 2 >nul')
		
}



// // // // TASKBAR THINGS

remove(type="taskbar" find=title.desktop)

