criptencoding utf-8

" ##### tabline settings #####
" usage : set tabline=%!MyTabLine()

function MyTabLine()
	let s = ''
	let margin = 2
	let tabnum = tabpagenr('$')
	let tabcharnum = winwidth(0) / tabnum - margin
	for i in range(tabnum)
		if i + 1 == tabpagenr()
			let s .= '%#TabLineSel#'
		else
			let s .= '%#TabLine#'
		endif

		" make label with MyTabLabel()
		let s .= ' %{MyTabLabel(' . (i + 1) . ' , ' . tabcharnum . ')} '
	endfor

	" fill blank space with TabLineFill
	let s .= '%#TabLineFill#%T'

	return s
endfunction

function MyTabLabel(n, tabcharnum)
	let bufID = tabpagebuflist(a:n)[tabpagewinnr(a:n)-1]
	let fullpath = bufname(bufID)
	let filename = fnamemodify(fullpath, ":t:r")
	if filename == ""
		let filename = "[no name]"
	endif

	let extension = fnamemodify(fullpath, ":e")
	if 0 < strlen(extension)
		let extension = "." . extension
	endif

	" if the file modified, put * 
	if getbufvar(bufID, "&modified")
		let header = a:n . "*"
	else
		let header = a:n . " "
	endif

	let targetstr = header . filename . extension
	let erasenum = strlen(targetstr) - a:tabcharnum

	if erasenum <= 0
		let output = targetstr . repeat(' ', a:tabcharnum-strlen(targetstr))

	elseif strlen(filename) - erasenum - 1 <= 0
		let output = targetstr[0:a:tabcharnum-2] . "~"

	else
		let shortened_filename = filename[0:strlen(filename)-erasenum-2] . "~"
		let output = header . shortened_filename . extension
	endif

	return output
endfunction
