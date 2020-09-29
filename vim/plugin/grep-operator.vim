nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

function s:Grep(word)
    normal ma
    let buffernr = winbufnr(0)
    "The ! here prevents the cursor from jumping to the first matched result
    silent execute "grep " . a:word
    "Let vim-qf help us open the window, so we do nothing here
    redraw! " regenerate the window
    "Go back to the previous buffer
    silent execute "buffer " . buffernr
    normal g`a
    copen
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
    let grepword = shellescape(@@)
    call <SID>Grep(grepword)
    let @@ = saved_unnamed_register
endfunction

" ----- make git grep work
set grepprg=git\ --no-pager\ grep\ -n\ --untracked

command! -nargs=1 Grep call s:Grep(<f-args>)
