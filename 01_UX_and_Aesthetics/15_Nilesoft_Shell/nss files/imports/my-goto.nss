// Custom Unified Go To Menu (Temporary & Registry)
menu(title='Go To' mode=mode.none type='taskbar|back|desktop' image=\uE14A) {
	
	// -- 1. Initialize Temporary Variables OK --
	// default order
	$do='0123456789'
	// next item
	$ni = 0
	// item paths
	$ip = ''
	// shift-delete: physical index into $ip
	$idx = 0
	$tip_goto_remove=["\xE1A7 Press SHIFT key to remove " + this.title + " from the list", tip.warning, 1.0]
	
	
	
	// -- 2. Initialize Registry Variables --
	$reg_path = 'HKEY_CURRENT_USER\Software\Nilesoft\Shell\GoTo'
	$dir_max = 9
	$counter = len(reg.values(reg_path))
	$p00=null
	$p01=null
	$p02=null
	$p03=null
	$p04=null
	$p05=null
	$p06=null
	$p07=null
	$p08=null
	$p09=null
	
	menu(expanded='true' title={
		p00=reg.get(reg_path, 0)
		p01=reg.get(reg_path, 1)
		p02=reg.get(reg_path, 2)
		p03=reg.get(reg_path, 3)
		p04=reg.get(reg_path, 4)
		p05=reg.get(reg_path, 5)
		p06=reg.get(reg_path, 6)
		p07=reg.get(reg_path, 7)
		p08=reg.get(reg_path, 8)
		p09=reg.get(reg_path, 9)
	}) {}
	
	$goto_has_reg=path.exists(p00) or path.exists(p01) or path.exists(p02) or path.exists(p03) or path.exists(p04) or path.exists(p05) or path.exists(p06) or path.exists(p07) or path.exists(p08) or path.exists(p09)
	$goto_has_temp=path.exists(ip[toint(do[0])]) or path.exists(ip[toint(do[1])]) or path.exists(ip[toint(do[2])]) or path.exists(ip[toint(do[3])]) or path.exists(ip[toint(do[4])]) or path.exists(ip[toint(do[5])]) or path.exists(ip[toint(do[6])]) or path.exists(ip[toint(do[7])]) or path.exists(ip[toint(do[8])]) or path.exists(ip[toint(do[9])])
		
		// --- 1. Temporary Paths (shift+click removes displayed path) ---
	item(title=ip[toint(do[0])] where=path.exists(ip[toint(do[0])]) image=\uE1F4 tip=tip_goto_remove commands{
		cmd=if(keys.shift(), { idx=toint(do[0]) ip=if(idx==0,[ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==1,[ip[0], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==2,[ip[0], ip[1], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==3,[ip[0], ip[1], ip[2], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==4,[ip[0], ip[1], ip[2], ip[3], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==5,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[6], ip[7], ip[8], ip[9], ''], if(idx==6,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[7], ip[8], ip[9], ''], if(idx==7,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[8], ip[9], ''], if(idx==8,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[9], ''], [ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], '']))))))))) ni=(ni-1) do='0123456789' }, if(window.name=='CabinetWClass', command.navigate(this.title), this.title))
	})
	item(title=ip[toint(do[1])] where=path.exists(ip[toint(do[1])]) image=\uE1F4 tip=tip_goto_remove commands{
		cmd=if(keys.shift(), { idx=toint(do[1]) ip=if(idx==0,[ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==1,[ip[0], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==2,[ip[0], ip[1], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==3,[ip[0], ip[1], ip[2], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==4,[ip[0], ip[1], ip[2], ip[3], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==5,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[6], ip[7], ip[8], ip[9], ''], if(idx==6,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[7], ip[8], ip[9], ''], if(idx==7,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[8], ip[9], ''], if(idx==8,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[9], ''], [ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], '']))))))))) ni=(ni-1) do='0123456789' }, if(window.name=='CabinetWClass', command.navigate(this.title), this.title)),
		cmd=if(!keys.shift(), { do=str.get(do, 1)+str.remove(do, 1, 1) })})
	item(title=ip[toint(do[2])] where=path.exists(ip[toint(do[2])]) image=\uE1F4 tip=tip_goto_remove commands{
		cmd=if(keys.shift(), { idx=toint(do[2]) ip=if(idx==0,[ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==1,[ip[0], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==2,[ip[0], ip[1], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==3,[ip[0], ip[1], ip[2], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==4,[ip[0], ip[1], ip[2], ip[3], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==5,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[6], ip[7], ip[8], ip[9], ''], if(idx==6,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[7], ip[8], ip[9], ''], if(idx==7,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[8], ip[9], ''], if(idx==8,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[9], ''], [ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], '']))))))))) ni=(ni-1) do='0123456789' }, if(window.name=='CabinetWClass', command.navigate(this.title), this.title)),
		cmd=if(!keys.shift(), { do=str.get(do, 2)+str.remove(do, 2, 1) })})
	item(title=ip[toint(do[3])] where=path.exists(ip[toint(do[3])]) image=\uE1F4 tip=tip_goto_remove commands{
		cmd=if(keys.shift(), { idx=toint(do[3]) ip=if(idx==0,[ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==1,[ip[0], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==2,[ip[0], ip[1], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==3,[ip[0], ip[1], ip[2], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==4,[ip[0], ip[1], ip[2], ip[3], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==5,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[6], ip[7], ip[8], ip[9], ''], if(idx==6,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[7], ip[8], ip[9], ''], if(idx==7,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[8], ip[9], ''], if(idx==8,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[9], ''], [ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], '']))))))))) ni=(ni-1) do='0123456789' }, if(window.name=='CabinetWClass', command.navigate(this.title), this.title)),
		cmd=if(!keys.shift(), { do=str.get(do, 3)+str.remove(do, 3, 1) })})
	item(title=ip[toint(do[4])] where=path.exists(ip[toint(do[4])]) image=\uE1F4 tip=tip_goto_remove commands{
		cmd=if(keys.shift(), { idx=toint(do[4]) ip=if(idx==0,[ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==1,[ip[0], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==2,[ip[0], ip[1], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==3,[ip[0], ip[1], ip[2], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==4,[ip[0], ip[1], ip[2], ip[3], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==5,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[6], ip[7], ip[8], ip[9], ''], if(idx==6,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[7], ip[8], ip[9], ''], if(idx==7,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[8], ip[9], ''], if(idx==8,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[9], ''], [ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], '']))))))))) ni=(ni-1) do='0123456789' }, if(window.name=='CabinetWClass', command.navigate(this.title), this.title)),
		cmd=if(!keys.shift(), { do=str.get(do, 4)+str.remove(do, 4, 1) })})
	item(title=ip[toint(do[5])] where=path.exists(ip[toint(do[5])]) image=\uE1F4 tip=tip_goto_remove commands{
		cmd=if(keys.shift(), { idx=toint(do[5]) ip=if(idx==0,[ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==1,[ip[0], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==2,[ip[0], ip[1], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==3,[ip[0], ip[1], ip[2], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==4,[ip[0], ip[1], ip[2], ip[3], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==5,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[6], ip[7], ip[8], ip[9], ''], if(idx==6,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[7], ip[8], ip[9], ''], if(idx==7,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[8], ip[9], ''], if(idx==8,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[9], ''], [ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], '']))))))))) ni=(ni-1) do='0123456789' }, if(window.name=='CabinetWClass', command.navigate(this.title), this.title)),
		cmd=if(!keys.shift(), { do=str.get(do, 5)+str.remove(do, 5, 1) })})
	item(title=ip[toint(do[6])] where=path.exists(ip[toint(do[6])]) image=\uE1F4 tip=tip_goto_remove commands{
		cmd=if(keys.shift(), { idx=toint(do[6]) ip=if(idx==0,[ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==1,[ip[0], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==2,[ip[0], ip[1], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==3,[ip[0], ip[1], ip[2], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==4,[ip[0], ip[1], ip[2], ip[3], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==5,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[6], ip[7], ip[8], ip[9], ''], if(idx==6,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[7], ip[8], ip[9], ''], if(idx==7,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[8], ip[9], ''], if(idx==8,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[9], ''], [ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], '']))))))))) ni=(ni-1) do='0123456789' }, if(window.name=='CabinetWClass', command.navigate(this.title), this.title)),
		cmd=if(!keys.shift(), { do=str.get(do, 6)+str.remove(do, 6, 1) })})
	item(title=ip[toint(do[7])] where=path.exists(ip[toint(do[7])]) image=\uE1F4 tip=tip_goto_remove commands{
		cmd=if(keys.shift(), { idx=toint(do[7]) ip=if(idx==0,[ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==1,[ip[0], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==2,[ip[0], ip[1], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==3,[ip[0], ip[1], ip[2], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==4,[ip[0], ip[1], ip[2], ip[3], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==5,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[6], ip[7], ip[8], ip[9], ''], if(idx==6,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[7], ip[8], ip[9], ''], if(idx==7,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[8], ip[9], ''], if(idx==8,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[9], ''], [ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], '']))))))))) ni=(ni-1) do='0123456789' }, if(window.name=='CabinetWClass', command.navigate(this.title), this.title)),
		cmd=if(!keys.shift(), { do=str.get(do, 7)+str.remove(do, 7, 1) })})
	item(title=ip[toint(do[8])] where=path.exists(ip[toint(do[8])]) image=\uE1F4 tip=tip_goto_remove commands{
		cmd=if(keys.shift(), { idx=toint(do[8]) ip=if(idx==0,[ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==1,[ip[0], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==2,[ip[0], ip[1], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==3,[ip[0], ip[1], ip[2], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==4,[ip[0], ip[1], ip[2], ip[3], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==5,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[6], ip[7], ip[8], ip[9], ''], if(idx==6,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[7], ip[8], ip[9], ''], if(idx==7,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[8], ip[9], ''], if(idx==8,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[9], ''], [ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], '']))))))))) ni=(ni-1) do='0123456789' }, if(window.name=='CabinetWClass', command.navigate(this.title), this.title)),
		cmd=if(!keys.shift(), { do=str.get(do, 8)+str.remove(do, 8, 1) })})
	item(title=ip[toint(do[9])] where=path.exists(ip[toint(do[9])]) image=\uE1F4 tip=tip_goto_remove commands{
		cmd=if(keys.shift(), { idx=toint(do[9]) ip=if(idx==0,[ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==1,[ip[0], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==2,[ip[0], ip[1], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==3,[ip[0], ip[1], ip[2], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==4,[ip[0], ip[1], ip[2], ip[3], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==5,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[6], ip[7], ip[8], ip[9], ''], if(idx==6,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[7], ip[8], ip[9], ''], if(idx==7,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[8], ip[9], ''], if(idx==8,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[9], ''], [ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], '']))))))))) ni=(ni-1) do='0123456789' }, if(window.name=='CabinetWClass', command.navigate(this.title), this.title)),
		cmd=if(!keys.shift(), { do=str.get(do, 9)+str.remove(do, 9, 1) })})



		// --- 2. Separator OK ---
		// Visually splits Temp and Registry paths ONLY if both lists have items populated
		separator(where=(goto_has_temp and goto_has_reg))




		// --- 3. Registry Paths (shift+click cascades keys) ---
		item(title=if(len(path.location.name(p00))==1, p00, '...\@path.location.name(p00)\@path.title(p00)') where=path.exists(p00) image=\uE1F4 tip=[p00+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] cmd=if(keys.shift(), { if(counter>1, reg.set(reg_path, 0, p01)) if(counter>2, reg.set(reg_path, 1, p02)) if(counter>3, reg.set(reg_path, 2, p03)) if(counter>4, reg.set(reg_path, 3, p04)) if(counter>5, reg.set(reg_path, 4, p05)) if(counter>6, reg.set(reg_path, 5, p06)) if(counter>7, reg.set(reg_path, 6, p07)) if(counter>8, reg.set(reg_path, 7, p08)) if(counter>9, reg.set(reg_path, 8, p09)) reg.delete(reg_path, counter-1) counter=len(reg.values(reg_path)) }, if(window.name=='CabinetWClass', command.navigate(p00), p00)))
		item(title=if(len(path.location.name(p01))==1, p01, '...\@path.location.name(p01)\@path.title(p01)') where=path.exists(p01) image=\uE1F4 tip=[p01+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] cmd=if(keys.shift(), { if(counter>2, reg.set(reg_path, 1, p02)) if(counter>3, reg.set(reg_path, 2, p03)) if(counter>4, reg.set(reg_path, 3, p04)) if(counter>5, reg.set(reg_path, 4, p05)) if(counter>6, reg.set(reg_path, 5, p06)) if(counter>7, reg.set(reg_path, 6, p07)) if(counter>8, reg.set(reg_path, 7, p08)) if(counter>9, reg.set(reg_path, 8, p09)) reg.delete(reg_path, counter-1) counter=len(reg.values(reg_path)) }, if(window.name=='CabinetWClass', command.navigate(p01), p01)))
		item(title=if(len(path.location.name(p02))==1, p02, '...\@path.location.name(p02)\@path.title(p02)') where=path.exists(p02) image=\uE1F4 tip=[p02+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] cmd=if(keys.shift(), { if(counter>3, reg.set(reg_path, 2, p03)) if(counter>4, reg.set(reg_path, 3, p04)) if(counter>5, reg.set(reg_path, 4, p05)) if(counter>6, reg.set(reg_path, 5, p06)) if(counter>7, reg.set(reg_path, 6, p07)) if(counter>8, reg.set(reg_path, 7, p08)) if(counter>9, reg.set(reg_path, 8, p09)) reg.delete(reg_path, counter-1) counter=len(reg.values(reg_path)) }, if(window.name=='CabinetWClass', command.navigate(p02), p02)))
		item(title=if(len(path.location.name(p03))==1, p03, '...\@path.location.name(p03)\@path.title(p03)') where=path.exists(p03) image=\uE1F4 tip=[p03+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] cmd=if(keys.shift(), { if(counter>4, reg.set(reg_path, 3, p04)) if(counter>5, reg.set(reg_path, 4, p05)) if(counter>6, reg.set(reg_path, 5, p06)) if(counter>7, reg.set(reg_path, 6, p07)) if(counter>8, reg.set(reg_path, 7, p08)) if(counter>9, reg.set(reg_path, 8, p09)) reg.delete(reg_path, counter-1) counter=len(reg.values(reg_path)) }, if(window.name=='CabinetWClass', command.navigate(p03), p03)))
		item(title=if(len(path.location.name(p04))==1, p04, '...\@path.location.name(p04)\@path.title(p04)') where=path.exists(p04) image=\uE1F4 tip=[p04+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] cmd=if(keys.shift(), { if(counter>5, reg.set(reg_path, 4, p05)) if(counter>6, reg.set(reg_path, 5, p06)) if(counter>7, reg.set(reg_path, 6, p07)) if(counter>8, reg.set(reg_path, 7, p08)) if(counter>9, reg.set(reg_path, 8, p09)) reg.delete(reg_path, counter-1) counter=len(reg.values(reg_path)) }, if(window.name=='CabinetWClass', command.navigate(p04), p04)))
		item(title=if(len(path.location.name(p05))==1, p05, '...\@path.location.name(p05)\@path.title(p05)') where=path.exists(p05) image=\uE1F4 tip=[p05+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] cmd=if(keys.shift(), { if(counter>6, reg.set(reg_path, 5, p06)) if(counter>7, reg.set(reg_path, 6, p07)) if(counter>8, reg.set(reg_path, 7, p08)) if(counter>9, reg.set(reg_path, 8, p09)) reg.delete(reg_path, counter-1) counter=len(reg.values(reg_path)) }, if(window.name=='CabinetWClass', command.navigate(p05), p05)))
		item(title=if(len(path.location.name(p06))==1, p06, '...\@path.location.name(p06)\@path.title(p06)') where=path.exists(p06) image=\uE1F4 tip=[p06+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] cmd=if(keys.shift(), { if(counter>7, reg.set(reg_path, 6, p07)) if(counter>8, reg.set(reg_path, 7, p08)) if(counter>9, reg.set(reg_path, 8, p09)) reg.delete(reg_path, counter-1) counter=len(reg.values(reg_path)) }, if(window.name=='CabinetWClass', command.navigate(p06), p06)))
		item(title=if(len(path.location.name(p07))==1, p07, '...\@path.location.name(p07)\@path.title(p07)') where=path.exists(p07) image=\uE1F4 tip=[p07+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] cmd=if(keys.shift(), { if(counter>8, reg.set(reg_path, 7, p08)) if(counter>9, reg.set(reg_path, 8, p09)) reg.delete(reg_path, counter-1) counter=len(reg.values(reg_path)) }, if(window.name=='CabinetWClass', command.navigate(p07), p07)))
		item(title=if(len(path.location.name(p08))==1, p08, '...\@path.location.name(p08)\@path.title(p08)') where=path.exists(p08) image=\uE1F4 tip=[p08+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] cmd=if(keys.shift(), { if(counter>9, reg.set(reg_path, 8, p09)) reg.delete(reg_path, counter-1) counter=len(reg.values(reg_path)) }, if(window.name=='CabinetWClass', command.navigate(p08), p08)))
		item(title=if(len(path.location.name(p09))==1, p09, '...\@path.location.name(p09)\@path.title(p09)') where=path.exists(p09) image=\uE1F4 tip=[p09+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] cmd=if(keys.shift(), { reg.delete(reg_path, counter-1) counter=len(reg.values(reg_path)) }, if(window.name=='CabinetWClass', command.navigate(p09), p09)))

		item(title='Empty list...' where=window.is_taskbar and !goto_has_temp and !goto_has_reg vis=label)




		// --- 4. Separator OK ---
		// Explicitly omits `taskbar` from type so this divider never renders there
		separator(type='drive|dir|back|desktop' where=(goto_has_temp or goto_has_reg))


		// --- 5. Add path to temporary OK ---
		item(title='Add path to Temporary' keys=ni+'/10' type='drive|dir|back.drive|back.dir|Desktop' 
		vis=if(len(do)<=ni or str.contains(str.join(ip,'|')+'|', sel+'|'), 'disable', 'normal') sep=if(goto_has_temp or goto_has_reg, 'bottom', 'none') image=icon.new_folder
		cmd={ ip=[  if(ni==0, sel, ip[0]), if(ni==1, sel, ip[1]), if(ni==2, sel, ip[2]), if(ni==3, sel, ip[3]), if(ni==4, sel, ip[4]), 
					if(ni==5, sel, ip[5]), if(ni==6, sel, ip[6]), if(ni==7, sel, ip[7]), if(ni==8, sel, ip[8]), if(ni==9, sel, ip[9])] ni+=1 })

		// --- 6. Add path to registry OK ---
		item(title='Add path to Registry' keys=counter+'/10'
			type='drive|dir|back.drive|back.dir|desktop' image=icon.new_folder sep=if(goto_has_temp or goto_has_reg, 'bottom', 'none')
			vis=if(counter>=dir_max or sel==p00 or sel==p01 or sel==p02 or sel==p03 or sel==p04 or sel==p05 or sel==p06 or sel==p07 or sel==p08 or sel==p09, 'disable', 'normal')
			cmd={ reg.set(reg_path, counter, sel, reg.sz) counter=len(reg.values(reg_path)) })

		// --- 7. Separator (Shift context) OK ---
		separator(type='back|desktop' where=(keys.shift() and (ni>0 or counter>0)))

		// --- 8. Clear temporary OK ---
		item(title='Clear Temporary' where=(ni>0 and keys.shift()) image=image.glyph(\uE0CE) type='back|desktop' sep='both' cmd={ do='0123456789' ni=0 ip='' })

		// --- 9. Clear registry OK ---
		item(title='Clear Registry' type='back|desktop' where=(counter>0 and keys.shift()) image=\uE0CE sep='both' cmd=reg.delete(reg_path) )

}
