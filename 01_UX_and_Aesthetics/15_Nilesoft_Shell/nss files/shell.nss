settings
{
	priority=1
	exclude.where = !process.is_explorer
	showdelay = 200
	// Options to allow modification of system items
	modify.remove.duplicate=1
	tip.enabled=true
}


// Default import
import 'imports/theme.nss'
import 'imports/images.nss'

menu(mode="multiple" title="Pin/Unpin" image=icon.pin)
{
}

menu(mode="multiple" title=title.more_options image=icon.more_options)
{
}

// // NOT importing
// import 'imports/terminal.nss'
// import 'imports/develop.nss'
// import 'imports/all.security.env.nss'  
// import 'imports/all.security.permissions.nss'  
// import 'imports/goto.nss'

import 'D:\_installed\VScode repos\Windows-Setup-Blueprint\01_UX_and_Aesthetics\15_Nilesoft_Shell\nss files\imports\modify.nss'

// // CUSTOMIZED File-manage nss file... it imports 'commands.links.ps.nss' at the end
import 'D:\_installed\VScode repos\Windows-Setup-Blueprint\01_UX_and_Aesthetics\15_Nilesoft_Shell\nss files\imports\file-manage.nss'

import 'D:\_installed\VScode repos\Windows-Setup-Blueprint\01_UX_and_Aesthetics\15_Nilesoft_Shell\nss files\imports\taskbar.nss'
import 'D:\_installed\VScode repos\Windows-Setup-Blueprint\01_UX_and_Aesthetics\15_Nilesoft_Shell\nss files\imports\custom.nss'  
import 'D:\_installed\VScode repos\Windows-Setup-Blueprint\01_UX_and_Aesthetics\15_Nilesoft_Shell\nss files\imports\recycle.bin.nss'  

// // My CUSTOM GO TO 
import 'D:\_installed\VScode repos\Windows-Setup-Blueprint\01_UX_and_Aesthetics\15_Nilesoft_Shell\nss files\imports\my-goto.nss'