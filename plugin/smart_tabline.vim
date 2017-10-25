scriptencoding utf-8

if exists('g:loaded_smart_tabline')
    finish
endif
let g:loaded_smart_tabline = 1

let s:save_cpo = &cpo
set cpo&vim

set tabline=%!smart_tabline#SmartTabLine()

let &cpo = s:save_cpo
unlet s:save_cpo
