nnoremap <silent> <leader>0 :<c-u>call <SID>RestoreBuffersBeforeQf()<cr>

function! OpenEntryUnderCursor(stay)
    let linenr = line(".")
    wincmd p
    silent execute "cc" . linenr
    if a:stay
	wincmd p
    endif
endfunction

function! s:RestoreBuffersBeforeQf()
    if exists('s:saved_buffers') && has_key(s:saved_buffers, winnr())
	let bufnr = s:saved_buffers[winnr()]
	silent execute bufnr . "buffer"
	normal g`g
    endif
endfunction

function! s:SaveBuffersBeforeQf()
    let s:saved_buffers = {}
    for i in range(winnr('$'))
	wincmd w
	normal! mg
	let s:saved_buffers[winnr()] = winbufnr(0)
    endfor
endfunction

augroup my_quickfix
    autocmd!
    autocmd QuickFixCmdPre * call <SID>SaveBuffersBeforeQf()
augroup END
