
iabbrev se select
iabbrev td //TODO (minzhang):

" Show by default 4 spaces for a tab

" :GoBuild and :GoTestCompile
nnoremap :build :<C-u>call <SID>build_go_files()
nnoremap :test  <Plug>(go-test)
nnoremap :run  <Plug>(go-run)

nnoremap <C-g>d :GoDecls<cr>
nnoremap <C-g>r :GoReferrers<cr>
nnoremap <C-g>c :GoCallers<cr>


nnoremap <C-g>i :GoSameIds<cr>
nnoremap <C-g>ic :GoSameIdsClear<cr>

"commands :A, :AV, :AS and :AT
command! -bang A call go#alternate#Switch(<bang>0, 'edit')
command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
command! -bang AS call go#alternate#Switch(<bang>0, 'split')
command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

