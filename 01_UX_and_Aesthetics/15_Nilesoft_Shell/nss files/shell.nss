settings
{
	priority=1
	exclude.where = !process.is_explorer
	showdelay = 200
	// Options to allow modification of system items
	modify.remove.duplicate=1
	tip.enabled=true
}

import 'imports/theme.nss'
import 'imports/images.nss'
import 'imports/modify.nss'

menu(mode="multiple" title="Pin/Unpin" image=icon.pin)
{
}

menu(mode="multiple" title=title.more_options image=icon.more_options)
{
}

// import 'imports/terminal.nss'
// import 'imports/develop.nss'
// import 'imports/all.security.env.nss'  
// import 'imports/all.security.permissions.nss'  
// import 'imports/goto.nss'

// // CUSTOMIZED File-manage nss file... it imports 'commands.links.ps.nss' at the end
import 'imports/file-manage.nss'

import 'imports/taskbar.nss'
import 'imports/custom.nss'  
import 'imports/recycle.bin.nss'  

// // GO TO Things... not using temp because seems like dupe
// import 'imports/goto.temp.nss'  
import 'imports/goto.reg.nss'


// // // // TASKBAR THINGS
remove(type="taskbar" find=title.desktop)