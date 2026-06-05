// Custom Unified Go To Menu (Temporary & Registry)
menu(title='Go To' mode=mode.none type='taskbar|back|desktop' image=\uE14A) {
	
	// -- Path display settings --
	// true = show full path; false = show drive + last (N-1) folders (or full if path is short enough)
	// goto_*_parts supports 2, 3, 4, 5, 6 only; other values fall back to full path
	$goto_temp_full = false
	$goto_reg_full  = false
	$goto_temp_parts = 4
	$goto_reg_parts  = 4
	
	// -- 1. Initialize Temporary Variables OK --
	// default order
	$do='0123456789'
	// next item
	$ni = 0
	// item paths
	$ip = ''
	// shift-delete: physical index into $ip
	$idx = 0
	
	
	
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
	
	// path display scratch + precomputed menu titles (set in title block below)
	$p=null
	$goto_full=false
	$goto_parts=6
	$t00='' $t01='' $t02='' $t03='' $t04='' $t05='' $t06='' $t07='' $t08='' $t09=''
	$r00='' $r01='' $r02='' $r03='' $r04='' $r05='' $r06='' $r07='' $r08='' $r09=''
	$goto_title=if(goto_full, p, if(if(path.isroot(p), 1, if(path.location(p)==path.root(p), 2, if(path.location(path.location(p))==path.root(p), 3, if(path.location(path.location(path.location(p)))==path.root(p), 4, if(path.location(path.location(path.location(path.location(p))))==path.root(p), 5, if(path.location(path.location(path.location(path.location(path.location(p)))))==path.root(p), 6, if(path.location(path.location(path.location(path.location(path.location(path.location(p))))))==path.root(p), 7, if(path.location(path.location(path.location(path.location(path.location(path.location(path.location(p)))))))==path.root(p), 8, if(path.location(path.location(path.location(path.location(path.location(path.location(path.location(path.location(p))))))))==path.root(p), 9, if(path.location(path.location(path.location(path.location(path.location(path.location(path.location(path.location(path.location(p)))))))))==path.root(p), 10, 10))))))))))<=goto_parts, p, if(goto_parts==2, path.root(p)+'...\'+path.title(p), if(goto_parts==3, path.root(p)+'...\'+path.location.name(p)+'\'+path.title(p), if(goto_parts==4, path.root(p)+'...\'+path.location.name(path.location(p))+'\'+path.location.name(p)+'\'+path.title(p), if(goto_parts==5, path.root(p)+'...\'+path.location.name(path.location(path.location(p)))+'\'+path.location.name(path.location(p))+'\'+path.location.name(p)+'\'+path.title(p), if(goto_parts==6, path.root(p)+'...\'+path.location.name(path.location(path.location(path.location(p))))+'\'+path.location.name(path.location(path.location(p)))+'\'+path.location.name(path.location(p))+'\'+path.location.name(p)+'\'+path.title(p), p)))))))
	
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
		goto_full=goto_temp_full goto_parts=goto_temp_parts
		p=ip[toint(do[0])] t00=if(path.exists(p), goto_title, '')
		p=ip[toint(do[1])] t01=if(path.exists(p), goto_title, '')
		p=ip[toint(do[2])] t02=if(path.exists(p), goto_title, '')
		p=ip[toint(do[3])] t03=if(path.exists(p), goto_title, '')
		p=ip[toint(do[4])] t04=if(path.exists(p), goto_title, '')
		p=ip[toint(do[5])] t05=if(path.exists(p), goto_title, '')
		p=ip[toint(do[6])] t06=if(path.exists(p), goto_title, '')
		p=ip[toint(do[7])] t07=if(path.exists(p), goto_title, '')
		p=ip[toint(do[8])] t08=if(path.exists(p), goto_title, '')
		p=ip[toint(do[9])] t09=if(path.exists(p), goto_title, '')
		goto_full=goto_reg_full goto_parts=goto_reg_parts
		p=p00 r00=if(path.exists(p00), goto_title, '')
		p=p01 r01=if(path.exists(p01), goto_title, '')
		p=p02 r02=if(path.exists(p02), goto_title, '')
		p=p03 r03=if(path.exists(p03), goto_title, '')
		p=p04 r04=if(path.exists(p04), goto_title, '')
		p=p05 r05=if(path.exists(p05), goto_title, '')
		p=p06 r06=if(path.exists(p06), goto_title, '')
		p=p07 r07=if(path.exists(p07), goto_title, '')
		p=p08 r08=if(path.exists(p08), goto_title, '')
		p=p09 r09=if(path.exists(p09), goto_title, '')
	}) {}
	
	$goto_has_reg=path.exists(p00) or path.exists(p01) or path.exists(p02) or path.exists(p03) or path.exists(p04) or path.exists(p05) or path.exists(p06) or path.exists(p07) or path.exists(p08) or path.exists(p09)
	$goto_has_temp=path.exists(ip[toint(do[0])]) or path.exists(ip[toint(do[1])]) or path.exists(ip[toint(do[2])]) or path.exists(ip[toint(do[3])]) or path.exists(ip[toint(do[4])]) or path.exists(ip[toint(do[5])]) or path.exists(ip[toint(do[6])]) or path.exists(ip[toint(do[7])]) or path.exists(ip[toint(do[8])]) or path.exists(ip[toint(do[9])])
		
		// --- 1. Temporary Paths (shift+click removes displayed path) ---
	item(title=t00 where=path.exists(ip[toint(do[0])]) image=\uE1F4 tip=[ip[toint(do[0])]+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] commands{
		cmd=if(keys.shift(), { idx=toint(do[0]) ip=if(idx==0,[ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==1,[ip[0], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==2,[ip[0], ip[1], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==3,[ip[0], ip[1], ip[2], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==4,[ip[0], ip[1], ip[2], ip[3], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==5,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[6], ip[7], ip[8], ip[9], ''], if(idx==6,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[7], ip[8], ip[9], ''], if(idx==7,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[8], ip[9], ''], if(idx==8,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[9], ''], [ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], '']))))))))) ni=(ni-1) do='0123456789' }, if(window.name=='CabinetWClass', command.navigate(ip[toint(do[0])]), ip[toint(do[0])]))
	})
	item(title=t01 where=path.exists(ip[toint(do[1])]) image=\uE1F4 tip=[ip[toint(do[1])]+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] commands{
		cmd=if(keys.shift(), { idx=toint(do[1]) ip=if(idx==0,[ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==1,[ip[0], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==2,[ip[0], ip[1], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==3,[ip[0], ip[1], ip[2], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==4,[ip[0], ip[1], ip[2], ip[3], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==5,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[6], ip[7], ip[8], ip[9], ''], if(idx==6,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[7], ip[8], ip[9], ''], if(idx==7,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[8], ip[9], ''], if(idx==8,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[9], ''], [ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], '']))))))))) ni=(ni-1) do='0123456789' }, if(window.name=='CabinetWClass', command.navigate(ip[toint(do[1])]), ip[toint(do[1])])),
		cmd=if(!keys.shift(), { do=str.get(do, 1)+str.remove(do, 1, 1) })})
	item(title=t02 where=path.exists(ip[toint(do[2])]) image=\uE1F4 tip=[ip[toint(do[2])]+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] commands{
		cmd=if(keys.shift(), { idx=toint(do[2]) ip=if(idx==0,[ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==1,[ip[0], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==2,[ip[0], ip[1], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==3,[ip[0], ip[1], ip[2], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==4,[ip[0], ip[1], ip[2], ip[3], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==5,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[6], ip[7], ip[8], ip[9], ''], if(idx==6,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[7], ip[8], ip[9], ''], if(idx==7,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[8], ip[9], ''], if(idx==8,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[9], ''], [ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], '']))))))))) ni=(ni-1) do='0123456789' }, if(window.name=='CabinetWClass', command.navigate(ip[toint(do[2])]), ip[toint(do[2])])),
		cmd=if(!keys.shift(), { do=str.get(do, 2)+str.remove(do, 2, 1) })})
	item(title=t03 where=path.exists(ip[toint(do[3])]) image=\uE1F4 tip=[ip[toint(do[3])]+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] commands{
		cmd=if(keys.shift(), { idx=toint(do[3]) ip=if(idx==0,[ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==1,[ip[0], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==2,[ip[0], ip[1], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==3,[ip[0], ip[1], ip[2], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==4,[ip[0], ip[1], ip[2], ip[3], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==5,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[6], ip[7], ip[8], ip[9], ''], if(idx==6,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[7], ip[8], ip[9], ''], if(idx==7,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[8], ip[9], ''], if(idx==8,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[9], ''], [ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], '']))))))))) ni=(ni-1) do='0123456789' }, if(window.name=='CabinetWClass', command.navigate(ip[toint(do[3])]), ip[toint(do[3])])),
		cmd=if(!keys.shift(), { do=str.get(do, 3)+str.remove(do, 3, 1) })})
	item(title=t04 where=path.exists(ip[toint(do[4])]) image=\uE1F4 tip=[ip[toint(do[4])]+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] commands{
		cmd=if(keys.shift(), { idx=toint(do[4]) ip=if(idx==0,[ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==1,[ip[0], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==2,[ip[0], ip[1], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==3,[ip[0], ip[1], ip[2], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==4,[ip[0], ip[1], ip[2], ip[3], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==5,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[6], ip[7], ip[8], ip[9], ''], if(idx==6,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[7], ip[8], ip[9], ''], if(idx==7,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[8], ip[9], ''], if(idx==8,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[9], ''], [ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], '']))))))))) ni=(ni-1) do='0123456789' }, if(window.name=='CabinetWClass', command.navigate(ip[toint(do[4])]), ip[toint(do[4])])),
		cmd=if(!keys.shift(), { do=str.get(do, 4)+str.remove(do, 4, 1) })})
	item(title=t05 where=path.exists(ip[toint(do[5])]) image=\uE1F4 tip=[ip[toint(do[5])]+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] commands{
		cmd=if(keys.shift(), { idx=toint(do[5]) ip=if(idx==0,[ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==1,[ip[0], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==2,[ip[0], ip[1], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==3,[ip[0], ip[1], ip[2], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==4,[ip[0], ip[1], ip[2], ip[3], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==5,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[6], ip[7], ip[8], ip[9], ''], if(idx==6,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[7], ip[8], ip[9], ''], if(idx==7,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[8], ip[9], ''], if(idx==8,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[9], ''], [ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], '']))))))))) ni=(ni-1) do='0123456789' }, if(window.name=='CabinetWClass', command.navigate(ip[toint(do[5])]), ip[toint(do[5])])),
		cmd=if(!keys.shift(), { do=str.get(do, 5)+str.remove(do, 5, 1) })})
	item(title=t06 where=path.exists(ip[toint(do[6])]) image=\uE1F4 tip=[ip[toint(do[6])]+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] commands{
		cmd=if(keys.shift(), { idx=toint(do[6]) ip=if(idx==0,[ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==1,[ip[0], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==2,[ip[0], ip[1], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==3,[ip[0], ip[1], ip[2], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==4,[ip[0], ip[1], ip[2], ip[3], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==5,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[6], ip[7], ip[8], ip[9], ''], if(idx==6,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[7], ip[8], ip[9], ''], if(idx==7,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[8], ip[9], ''], if(idx==8,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[9], ''], [ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], '']))))))))) ni=(ni-1) do='0123456789' }, if(window.name=='CabinetWClass', command.navigate(ip[toint(do[6])]), ip[toint(do[6])])),
		cmd=if(!keys.shift(), { do=str.get(do, 6)+str.remove(do, 6, 1) })})
	item(title=t07 where=path.exists(ip[toint(do[7])]) image=\uE1F4 tip=[ip[toint(do[7])]+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] commands{
		cmd=if(keys.shift(), { idx=toint(do[7]) ip=if(idx==0,[ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==1,[ip[0], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==2,[ip[0], ip[1], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==3,[ip[0], ip[1], ip[2], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==4,[ip[0], ip[1], ip[2], ip[3], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==5,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[6], ip[7], ip[8], ip[9], ''], if(idx==6,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[7], ip[8], ip[9], ''], if(idx==7,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[8], ip[9], ''], if(idx==8,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[9], ''], [ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], '']))))))))) ni=(ni-1) do='0123456789' }, if(window.name=='CabinetWClass', command.navigate(ip[toint(do[7])]), ip[toint(do[7])])),
		cmd=if(!keys.shift(), { do=str.get(do, 7)+str.remove(do, 7, 1) })})
	item(title=t08 where=path.exists(ip[toint(do[8])]) image=\uE1F4 tip=[ip[toint(do[8])]+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] commands{
		cmd=if(keys.shift(), { idx=toint(do[8]) ip=if(idx==0,[ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==1,[ip[0], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==2,[ip[0], ip[1], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==3,[ip[0], ip[1], ip[2], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==4,[ip[0], ip[1], ip[2], ip[3], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==5,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[6], ip[7], ip[8], ip[9], ''], if(idx==6,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[7], ip[8], ip[9], ''], if(idx==7,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[8], ip[9], ''], if(idx==8,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[9], ''], [ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], '']))))))))) ni=(ni-1) do='0123456789' }, if(window.name=='CabinetWClass', command.navigate(ip[toint(do[8])]), ip[toint(do[8])])),
		cmd=if(!keys.shift(), { do=str.get(do, 8)+str.remove(do, 8, 1) })})
	item(title=t09 where=path.exists(ip[toint(do[9])]) image=\uE1F4 tip=[ip[toint(do[9])]+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] commands{
		cmd=if(keys.shift(), { idx=toint(do[9]) ip=if(idx==0,[ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==1,[ip[0], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==2,[ip[0], ip[1], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==3,[ip[0], ip[1], ip[2], ip[4], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==4,[ip[0], ip[1], ip[2], ip[3], ip[5], ip[6], ip[7], ip[8], ip[9], ''], if(idx==5,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[6], ip[7], ip[8], ip[9], ''], if(idx==6,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[7], ip[8], ip[9], ''], if(idx==7,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[8], ip[9], ''], if(idx==8,[ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[9], ''], [ip[0], ip[1], ip[2], ip[3], ip[4], ip[5], ip[6], ip[7], ip[8], '']))))))))) ni=(ni-1) do='0123456789' }, if(window.name=='CabinetWClass', command.navigate(ip[toint(do[9])]), ip[toint(do[9])])),
		cmd=if(!keys.shift(), { do=str.get(do, 9)+str.remove(do, 9, 1) })})



		// --- 2. Separator OK ---
		// Visually splits Temp and Registry paths ONLY if both lists have items populated
		separator(where=(goto_has_temp and goto_has_reg))




		// --- 3. Registry Paths (shift+click cascades keys) ---
		item(title=r00 where=path.exists(p00) image=\uE1F4 tip=[p00+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] cmd=if(keys.shift(), { if(counter>1, reg.set(reg_path, 0, p01)) if(counter>2, reg.set(reg_path, 1, p02)) if(counter>3, reg.set(reg_path, 2, p03)) if(counter>4, reg.set(reg_path, 3, p04)) if(counter>5, reg.set(reg_path, 4, p05)) if(counter>6, reg.set(reg_path, 5, p06)) if(counter>7, reg.set(reg_path, 6, p07)) if(counter>8, reg.set(reg_path, 7, p08)) if(counter>9, reg.set(reg_path, 8, p09)) reg.delete(reg_path, counter-1) counter=len(reg.values(reg_path)) }, if(window.name=='CabinetWClass', command.navigate(p00), p00)))
		item(title=r01 where=path.exists(p01) image=\uE1F4 tip=[p01+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] cmd=if(keys.shift(), { if(counter>2, reg.set(reg_path, 1, p02)) if(counter>3, reg.set(reg_path, 2, p03)) if(counter>4, reg.set(reg_path, 3, p04)) if(counter>5, reg.set(reg_path, 4, p05)) if(counter>6, reg.set(reg_path, 5, p06)) if(counter>7, reg.set(reg_path, 6, p07)) if(counter>8, reg.set(reg_path, 7, p08)) if(counter>9, reg.set(reg_path, 8, p09)) reg.delete(reg_path, counter-1) counter=len(reg.values(reg_path)) }, if(window.name=='CabinetWClass', command.navigate(p01), p01)))
		item(title=r02 where=path.exists(p02) image=\uE1F4 tip=[p02+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] cmd=if(keys.shift(), { if(counter>3, reg.set(reg_path, 2, p03)) if(counter>4, reg.set(reg_path, 3, p04)) if(counter>5, reg.set(reg_path, 4, p05)) if(counter>6, reg.set(reg_path, 5, p06)) if(counter>7, reg.set(reg_path, 6, p07)) if(counter>8, reg.set(reg_path, 7, p08)) if(counter>9, reg.set(reg_path, 8, p09)) reg.delete(reg_path, counter-1) counter=len(reg.values(reg_path)) }, if(window.name=='CabinetWClass', command.navigate(p02), p02)))
		item(title=r03 where=path.exists(p03) image=\uE1F4 tip=[p03+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] cmd=if(keys.shift(), { if(counter>4, reg.set(reg_path, 3, p04)) if(counter>5, reg.set(reg_path, 4, p05)) if(counter>6, reg.set(reg_path, 5, p06)) if(counter>7, reg.set(reg_path, 6, p07)) if(counter>8, reg.set(reg_path, 7, p08)) if(counter>9, reg.set(reg_path, 8, p09)) reg.delete(reg_path, counter-1) counter=len(reg.values(reg_path)) }, if(window.name=='CabinetWClass', command.navigate(p03), p03)))
		item(title=r04 where=path.exists(p04) image=\uE1F4 tip=[p04+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] cmd=if(keys.shift(), { if(counter>5, reg.set(reg_path, 4, p05)) if(counter>6, reg.set(reg_path, 5, p06)) if(counter>7, reg.set(reg_path, 6, p07)) if(counter>8, reg.set(reg_path, 7, p08)) if(counter>9, reg.set(reg_path, 8, p09)) reg.delete(reg_path, counter-1) counter=len(reg.values(reg_path)) }, if(window.name=='CabinetWClass', command.navigate(p04), p04)))
		item(title=r05 where=path.exists(p05) image=\uE1F4 tip=[p05+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] cmd=if(keys.shift(), { if(counter>6, reg.set(reg_path, 5, p06)) if(counter>7, reg.set(reg_path, 6, p07)) if(counter>8, reg.set(reg_path, 7, p08)) if(counter>9, reg.set(reg_path, 8, p09)) reg.delete(reg_path, counter-1) counter=len(reg.values(reg_path)) }, if(window.name=='CabinetWClass', command.navigate(p05), p05)))
		item(title=r06 where=path.exists(p06) image=\uE1F4 tip=[p06+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] cmd=if(keys.shift(), { if(counter>7, reg.set(reg_path, 6, p07)) if(counter>8, reg.set(reg_path, 7, p08)) if(counter>9, reg.set(reg_path, 8, p09)) reg.delete(reg_path, counter-1) counter=len(reg.values(reg_path)) }, if(window.name=='CabinetWClass', command.navigate(p06), p06)))
		item(title=r07 where=path.exists(p07) image=\uE1F4 tip=[p07+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] cmd=if(keys.shift(), { if(counter>8, reg.set(reg_path, 7, p08)) if(counter>9, reg.set(reg_path, 8, p09)) reg.delete(reg_path, counter-1) counter=len(reg.values(reg_path)) }, if(window.name=='CabinetWClass', command.navigate(p07), p07)))
		item(title=r08 where=path.exists(p08) image=\uE1F4 tip=[p08+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] cmd=if(keys.shift(), { if(counter>9, reg.set(reg_path, 8, p09)) reg.delete(reg_path, counter-1) counter=len(reg.values(reg_path)) }, if(window.name=='CabinetWClass', command.navigate(p08), p08)))
		item(title=r09 where=path.exists(p09) image=\uE1F4 tip=[p09+"\n\n\xE1A7 Press SHIFT key to remove this entry from the list", tip.warning, 1.0] cmd=if(keys.shift(), { reg.delete(reg_path, counter-1) counter=len(reg.values(reg_path)) }, if(window.name=='CabinetWClass', command.navigate(p09), p09)))

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
