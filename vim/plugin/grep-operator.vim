nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <silent> <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>
nnoremap <silent> <leader>gt :<c-u>call <SID>ToggleFlags()<cr>

"git grep runAuction -- '*.go' ':(exclude)*_test.go'
let g:grep_use_additional_flags = v:false
let b:grep_additional_flags = ''

" basically a grep but this keep the current window the same without going to
" the first search result
function! s:Grep(word)
    "the ! here prevents the cursor from jumping to the first matched result
    silent execute "grep! " . shellescape(a:word) . (g:grep_use_additional_flags ? b:grep_additional_flags : '')
    redraw! " regenerate the window
    "execute "normal! gg/" . a:word . '\r'
    "call RestoreBufferBeforeGrep()
    "Jump to the quickfix list
    "cwindow
endfunction

function! s:GrepOperator(type)
    let saved_unnamed_register = @@
    "visually select the range and yank it
    if a:type ==# 'v'
	execute "normal! `<v`>y"
    elseif a:type ==# 'char'
	execute "normal! `[v`]y"
    else
        return
    endif
    call <SID>Grep(@@)
    let @@ = saved_unnamed_register
endfunction

function! s:ToggleFlags()
    let g:grep_use_additional_flags = !g:grep_use_additional_flags
    echo "Setting additional grep flags to " . shellescape(g:grep_use_additional_flags ? b:grep_additional_flags : '')
endfunction

" ----- make git grep work
set grepprg=git\ --no-pager\ grep\ -n\ --untracked

command! -nargs=1 Grep call s:Grep(<f-args>)
