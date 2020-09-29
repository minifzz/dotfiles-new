nnoremap <leader>s :set operatorfunc=<SID>SearchOperator<cr>g@
vnoremap <leader>s :<c-u>call <SID>SearchOperator(visualmode())<cr>

function! s:SearchOperator(type)
    let saved_unnamed_register = @@
    "visually select the range and yank it
    if a:type ==# 'v'
	execute "normal! `<v`>y"
    elseif a:type ==# 'char'
	execute "normal! `[v`]y"
    else
        return
    endif
    echom @@
    execute "normal! /" . @@ . "\r"
    let @@ = saved_unnamed_register
endfunction
