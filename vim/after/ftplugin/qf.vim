nmap <silent> <buffer> h <Plug>(qf_previous_file)
nmap <silent> <buffer> l <Plug>(qf_next_file)
nmap <buffer> p <plug>(qf-preview-open)

let b:qfpreview = {
	    \ 'close': 'q',
	    \ 'top': 'g',
	    \ 'bottom': 'G',
	    \ 'scrollup': 'm',
	    \ 'scrolldown': 'n',
	    \ 'halfpageup': 'u',
	    \ 'halfpagedown': 'd',
	    \ 'fullpageup': 'b',
	    \ 'fullpagedown': 'f',
	    \ 'number': 1, 
	    \ 'next': 'j',
	    \ 'previous': 'k',
	    \ 'offset': 8, 
	    \ 'sign': {'text': '>>', 'texthl': 'Todo'}
	    \ }

" I copied this code from vim-qf, because I do not want to use 
" the full ack_style mapping set
" open entry in a new horizontal window
let b:qf_isLoc = !empty(getloclist(0))

" s: open entry in a new horizontal window
nnoremap <silent> <buffer> s <C-w><CR>

" v: open entry in a new vertical window.
if (b:qf_isLoc == 1 && get(g:, 'qf_loclist_window_bottom', 1))
	    \ || (b:qf_isLoc == 0 && get(g:, 'qf_window_bottom', 1))
    nnoremap <silent> <expr> <buffer> v &splitright ? "\<C-w>\<CR>\<C-w>L\<C-w>p\<C-w>J\<C-w>p" : "\<C-w>\<CR>\<C-w>H\<C-w>p\<C-w>J\<C-w>p"
else
    " don't move quickfix to bottom if qf_loclist_window_bottom is 0
    nnoremap <silent> <expr> <buffer> v &splitright ? "\<C-w>\<CR>\<C-w>L" : "\<C-w>\<CR>\<C-w>H"
endif

" t: open entry in a new tab.
nnoremap <silent> <buffer> t <C-w><CR><C-w>T

" i: open entry
nnoremap <silent> <buffer> i :<c-u>call quickfix#OpenEntryUnderCursor(0)<CR>
nnoremap <silent> <buffer> <CR> :<c-u>call quickfix#OpenEntryUnderCursor(0)<CR>

" o: open entry and come back
nnoremap <silent> <buffer> o :<c-u> call quickfix#OpenEntryUnderCursor(1)<CR>

" O: open entry and close the location/quickfix window.
if b:qf_isLoc == 1
    nnoremap <silent> <buffer> O <CR>:lclose<CR>
else
    nnoremap <silent> <buffer> O <CR>:cclose<CR>
endif
