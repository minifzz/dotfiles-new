nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <silent> <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>
nnoremap <silent> <leader>gt :<c-u>call <SID>ToggleGrepFlags()<cr>

let g:grep_use_additional_flags = v:false

" basically a grep but this keep the current window the same without going to
" the first search result
function! grep#Grep(word, ...)
    let word = escape(a:word, '#()\')
    let cmd = "Ag! " . shellescape(a:word) . join(a:000, ' ')
    if g:grep_use_additional_flags
	let cmd = cmd . b:grep_additional_flags
    endif
    echom cmd
    silent execute cmd
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
    call grep#Grep(@@)
    let @@ = saved_unnamed_register
endfunction

function! s:ToggleGrepFlags()
    if !exists('b:grep_additional_flags')
	echom "Did not set up addtion flags for this filetype"
	return
    endif
    let g:grep_use_additional_flags = !g:grep_use_additional_flags
    if g:grep_use_additional_flags
	echo "Set additional grep flags to " . b:grep_additional_flags
    else
	echo "Clear additional grep flags"
    endif
endfunction

command! -nargs=* Grep call grep#Grep(<f-args>)

augroup grep_flags
    autocmd!

    autocmd FileType go let g:grep_use_additional_flags = 1
    autocmd FileType go let b:grep_additional_flags = " --go --ignore '.*_test.go'"

augroup END
