nnoremap <leader>m :set operatorfunc=<SID>MyOp<cr>g@
vnoremap <silent> <leader>m :<c-u>call <SID>MyOp(visualmode())<cr>

"remove word surrounding by 1
function! s:MyOp(type)
    if a:type ==# 'v'
	execute 'normal! `<"_hx'
	execute 'normal! `>"_hx'
    else
	echo a:type
	execute 'normal! `]ma`[hx`ax'
    endif
endfunction
