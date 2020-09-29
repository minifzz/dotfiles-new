function! OpenQuickFix()
    echom "set quickfix window to " . winnr()
    let s:window_before_quickfix = winnr()
endfunction

function! OpenLocList()
    echom "set loclist window to " . winnr()
    let s:window_before_loclist = winnr()
endfunction

function! ReturnToWindowBefore(type)
    if a:type ==# "qf"
	echom "going back to " . s:window_before_quickfix
	execute s:window_before_quickfix . "wincmd w"
    elseif a:type ==# "loclist"
	execute s:window_before_loclist . "wincmd w"
    endif
endfunction

augroup my_quickfix
    autocmd!

    autocmd QuickFixCmdPost nested call OpenQuickFix()
    "autocmd QuickFixCmdPost nested call OpenLocList()
augroup END

autocmd QuickFixCmdPost call OpenQuickFix()
nnoremap <C-0> :call ReturnToWindowBefore("qf")
