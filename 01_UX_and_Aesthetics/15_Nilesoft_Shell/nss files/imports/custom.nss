// // // // // Remove the two Windows Media Player Legacy options and extra useless things

remove(find="Add to Windows Media Player Legacy list")
remove(find="Play with Windows Media Player Legacy")

remove(find="Add to Favorites")
remove(find="Browse with FastStone") 



// // // // // Move "New folder with selection" into the "File manage" group

modify(find="New folder with selection" menu="File manage" image=icon.new_folder)
modify(find="TeraCopy*" pos="bottom" menu="File manage")

// // // // // GROUPING Archiving Tools

// Create a new sub-menu
menu(title="Archiving Tools" image=\uE0AA) { }

// Move existing third-party items into that sub-menu
modify(find="NanaZip" menu="Archiving Tools")
modify(find="7-Zip" menu="Archiving Tools")
modify(find="WinRAR" menu="Archiving Tools")
modify(find="Extract All..." menu="Archiving Tools")



// // // // // // MOVING to More Options

modify(find="Scan with Microsoft Defender" menu="More options")
modify(find="Blip" menu="More options")


// // // // // // LAUNCH MENU (Requires holding SHIFT to appear)

menu(title='Open in...' 
	type='dir|back.dir|drive|back.drive|desktop' 
	where=(key.shift() and sel.count <= 1) 
	image=\uE0AB) 
{
	// 1. Search
	item(title='Search with Everything' 
		image='C:\Program Files\Everything 1.5a\Everything.exe' 
		cmd='C:\Program Files\Everything 1.5a\Everything.exe' 
		args='-search "@sel.path "')
		
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
}



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

