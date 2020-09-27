set nocompatible              
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" ----- Making Vim look good ------------------------------------------
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" ----- Vim as a programmer's text editor -----------------------------
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
"Plugin 'vim-syntastic/syntastic' "I'm going to disable syntastic for now
"since it is slow
"Plugin 'xolox/vim-misc'
"Plugin 'xolox/vim-easytags'
"Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mhinz/vim-startify' 
Plugin 'Valloric/YouCompleteMe'

" ----- Working with Git ----------------------------------------------
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'zivyangll/git-blame.vim'

" ----- Make grep works -------
Plugin 'rking/ag.vim'

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim' 
Plugin 'garbas/vim-snipmate'
" Optional:
Plugin 'honza/vim-snippets'

Plugin 'rhysd/vim-clang-format'

Plugin 'rizzatti/dash.vim'

"Plugin 'edkolev/tmuxline.vim'
Plugin 'fatih/vim-go'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'ervandew/supertab'
Plugin 'SirVer/ultisnips'

call vundle#end()
" END OF Vundle

filetype plugin indent on    " required
syntax on "syntax highlighting

"""""""""""""""""""""""""""""""""""""""""
""""""" Plugin-Specific Settings """"""""
"""""""""""""""""""""""""""""""""""""""""
" Set the colorscheme
" set Vim-specific sequences for RGB colors
set background=dark
let g:solarized_visibility = "high"
colorscheme solarized
" Manually set signcolumn and gitgutter's background color
highlight! link SignColumn LineNr
highlight! link GitGutterAdd DiffAdd
highlight! link GitGutterChange DiffChange
highlight! link GitGutterDelete DiffDelete
highlight! link GitGutterChangeDelete DiffChange

" ----- bling/vim-airline settings -----
" Always show statusbar
set laststatus=2

" Fancy arrow symbols, requires a patched font
" To install a patched font, run over to
"     https://github.com/abertsch/Menlo-for-Powerline
" download all the .ttf files, double-click on them and click "Install"
" Finally, uncomment the next line
" NOTE!!!! Also need to select the font Monlo-for-Powerline in the terminal preferance
let g:airline_powerline_fonts = 1

" Show PASTE if in paste mode
let g:airline_detect_paste=1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Show airline for tabs too
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='|'
let g:airline#extensions#tabline#formatter = 'default'

" Use the solarized theme for the Airline status bar
let g:airline_theme='solarized'

" ----- jistr/vim-nerdtree-tabs -----
" Open/close NERDTree Tabs with Shift+t
nnoremap <silent> <S-t> :NERDTreeTabsToggle<CR>
" To have NERDTree always open on startup
let g:nerdtree_tabs_open_on_console_startup = 0
" END OF plugin setups
"
" ----- startify do not change diretory
let g:startify_change_to_dir = 0

" ----- airblade/vim-gitgutter settings -----
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1
nnoremap <Leader>gb :Gblame<CR>
nnoremap :gs :Gstatus<CR>
nnoremap :gd :Gdiff<CR>

let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'
let g:gitgutter_override_sign_column_highlight = 1

set updatetime=100

" ----- make git grep work
"set grepprg=git\ grep\ -n\ --untracked
"nnoremap <silent> <C-k> :grep! "\b<C-R><C-W>\b"<CR>:cw<CR><CR>
let g:g_ag_prg="git\ grep\ -n\ --untracked" " use git grep instead of ag
let g:ag_highlight =1                       " highlight search terms
let g:ag_noremapping_message = 1                " display help messages
nnoremap <silent> <C-k> :Ag "\b<C-R><C-W>\b"<CR>

" ----- ctrl-p settings ---
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|bin\|go'
    \}
let g:ctrlp_max_files=0
let g:ctrlp_extensions = ['tag', 'dir']
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
let g:ctrlp_regexp = 1
let g:ctrlp_switch_buffer=0
let g:ctrlp_user_command = { 'types': { 1: ['.git', 'git ls-files -oc --exclude-standard'], 2: ['.hg', 'hg --cwd %s locate -I .'], }, 'fallback': 'find %s -type f' }

" ----- YCM settings ----
" default ycm compilation flags
" let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
" disable ycm autoconfirmation
" let g:ycm_confirm_extra_conf = 0
" get identifiers from tag files
" let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_error_symbol = '✘'
let g:ycm_warning_symbol = "▲"

" let g:ycm_always_populate_location_list = 1
let g:ycm_auto_hover=""

let s:ycm_hover_popup = -1
function s:Hover()
  let response = youcompleteme#GetCommandResponse( 'GetType' )
  if response == ''
    return
  endif

  call popup_hide( s:ycm_hover_popup )
  let s:ycm_hover_popup = popup_atcursor( balloon_split( response ), {} )
endfunction

nnoremap <silent> <leader>i :call <SID>Hover()<CR>

" ---- Supertab settings ----
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" ----- go settings ----
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

let g:go_auto_type_info = 0
let g:go_fmt_experimental = 1
let g:go_fmt_fail_silently = 1
"let g:go_doc_keywordprg_enabled = 0
" let g:go_bin_path = expand("~/goinstallbinaries/bin")
let g:go_def_mode = "godef"
"let g:go_def_mapping_enabled=0" 


augroup go
  autocmd!

  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

  " :GoTest
  autocmd FileType go nmap <leader>t  <Plug>(go-test)

  " :GoRun
  autocmd FileType go nmap <leader>r  <Plug>(go-run)

  " :GoCoverageToggle
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

  " :GoMetaLinter
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)

  " :GoDef but opens in a vertical split
  autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
  " :GoDef but opens in a horizontal split
  autocmd FileType go nmap <Leader>s <Plug>(go-def-split)
  
  " Open :GoDecls  with ctrl-g 
  autocmd Filetype go nmap <C-g> :GoDecls<cr>
    
  " GoReferers
  autocmd Filetype go nmap <Leader>r :GoReferrers<cr>
  autocmd Filetype go nmap <Leader>c :GoCallers<cr>

  " :GoAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

  
augroup END

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" let guru scope be the whole workspace
" let g:go_guru_scope = ["pinterest.com/ads/..."]


"""""""""""""""""""""""""""""""""""""
"""""" General settings """""""""""""
"""""""""""""""""""""""""""""""""""""
set showcmd "show partial commands
set hls "highlight searches
set incsearch                   " Shows the match while typing
set ignorecase "case insensitive search
set smartcase "except for capitals
set ai "auto indent
set ruler "display cursor position
set number "display line numbers
set confirm "display confirm dialog for unsaved changes
set backspace=indent,eol,start
set noexpandtab "use spaces, not real tabs
set shiftwidth=4 "set tabs to 4 spaces
set softtabstop=4
set tabstop=8
set shiftround
set number
set smartindent
set autoindent
set cindent
set ignorecase
set noerrorbells                " No beeps
set splitright                  " Vertical windows should be split to right
set splitbelow                  " Horizontal windows should split to bottom
set autowrite                   " Automatically save before :next, :make etc.
set hidden                      " Buffer should still exist if window is closed
set nocursorcolumn              " Do not highlight column (speeds up highlighting)
set nocursorline                " Do not highlight cursor (speeds up highlighting)
set lazyredraw                  " Wait to redraw

"Code folding
set foldmethod=indent
set foldlevel=99

"Set hybrid line numbering and autotoggle
set number relativenumber

set scrolloff=10                " always show at leat five lines visable above and below cursor
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Enable to copy to clipboard for operations like yank, delete, change and put
" http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
set clipboard^=unnamed

" This enables us to undo files even if you exit Vim.
if has('persistent_undo')
  set undofile
  set undodir=~/.config/vim/tmp/undo//
endif

"""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""" Mappings """"""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""
let mapleader = "\<Space>"

" Press - to turn off highlighting and clear any message already displayed.
nnoremap <silent> - :nohlsearch<Bar>:echo<CR>

"Use jk to return to normal mode
inoremap jk <Esc>
"toggle
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

"""""""""""""""""" Motion """""""""""""""""""
"Use Ctrl-a and Ctrl-e to jump to start/end of lines, like Emacs
inoremap <C-a> <Esc>^i
inoremap <C-e> <Esc>$a

"Select current word
nnoremap <Leader>w viw

"Use ctrl-a to select all
noremap <C-a> ggVG

"Up and down arrows use screen lines
noremap <Up> gk
noremap <Down> gj
inoremap <Up> <Esc>gka
inoremap <Down> <Esc>gja

nnoremap H _
nnoremap L g_
"""""""""""""""""" Editting """"""""""""""""" 
"Y copies until end of line
noremap Y y$
"search and replace current word
nnoremap <Leader>f :%s/\<<C-r><C-w>\>//g<Left><Left>

"Move current line down
nnoremap <leader>_ ddp

" Remove current line
inoremap <C-d> <esc>ddi
" Toggle capitalcase words
inoremap <C-w>~ <esc>b~<esc>ea
nnoremap <C-w>~ b~<esc>e
" Turn current word to uppercase
inoremap <C-w>u <esc>viwUea
nnoremap <C-w>u viwUe

"Wrap current word with double quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
"Wrap current word with single quotes
nnoremap <leader>' viw<esc>a"<esc>bi"<esc>lel

onoremap H _
onoremap L g_
onoremap <silent> u iw
onoremap <silent> o iW
onoremap <silent> U aw
onoremap <silent> O aW
onoremap <silent> iw <nop>
onoremap <silent> iW <nop>
onoremap <silent> aw <nop>
onoremap <silent> aW <nop>
" Operate on the current line
onoremap <silent> l :<c-u>normal! _vg_<cr>
" Operate on next brace
onoremap <silent> nb :<c-u>execute "normal! /(\r:nohlsearch\rvi("<cr>
" Operate on next brace
onoremap <silent> Nb :<c-u>execute "normal! /(\r:nohlsearch\rva("<cr>
" Operate on next curly brace
" Operate on next string, exclude the double quote
onoremap <silent> nB :<c-u>execute "normal! /\"\r:nohlsearch\rvi\""<cr>
" Operate on next string, include the double quote
onoremap <silent> NB :<c-u>execute "normal! /\"\r:nohlsearch\rva\""<cr>
onoremap <silent> n{ :<c-u>execute "normal! /{\r:nohlsearch\rvi{"<cr>
" Operate on next curly brace
onoremap <silent> N{ :<c-u>execute "normal! /{\r:nohlsearch\rva{"<cr>
" Operate on the right range side of an equation
onoremap = :<c-u>execute "normal! 0/=\r:nohlsearch\rwvg_"<cr>
" Operate on the left range side of an equation
onoremap - :<c-u>execute "normal! 0/=\r:nohlsearch\rbev^"<cr>
" Operate on an argument of a function
onoremap ia :<c-u>execute "normal! ?(\\\\|{\\\\|,\r:nohlsearch\rlma/\r:nohlsearch\rhv`a"<cr>

" Go inside the next brace
nnoremap gb :<c-u>execute "normal! /(\r:nohlsearch\rl"<cr>
" Go to the next argument, delimeters (|{|,
nnoremap ga :<c-u>execute "normal! /(\\\\|{\\\\|,\r:nohlsearch\rw"<cr>
nnoremap g{ :<c-u>execute "normal! /{\r:nohlsearch\rw"<cr>


" Go back to the exact spot of last modification line
nnoremap g. `.

"""""""""""" Windows and Tabs """"""""""""""" 
"Switch between windows
noremap <Tab> <C-w>w
noremap <S-Tab> <C-w>W

"Tab commands
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>
nnoremap tn :tabnew<CR>
nnoremap :te :tabe<Space>

"Buffer commands
nnoremap <Leader>bh :bfirst<CR>
nnoremap <Leader>bj :bnext<CR>
nnoremap <Leader>bk :bprev<CR>

" Navigating location list (errors)
nnoremap <Leader>lj :lnext<CR>
nnoremap <Leader>lk :lprevious<CR>

" Navigate quickfix window
noremap <C-n> :cnext<CR>
noremap <C-b> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :wqa<CR>

" Disable some commands to train muscle memories
nnoremap :wqa<CR> <nop>
nnoremap :w<CR> <nop>
nnoremap :q<CR> <nop>
nnoremap $ <nop>
nnoremap 0 <nop>
 
""""""""""""""""" Other """"""""""""""""""""" 
"gdb
noremap :gdb :ConqueGdb
noremap :gdbs :ConqueGdbSplit
noremap :gdbvs :ConqueGdbVSplit

"freeze vim latex auto insert
let g:Inoremap_FreezeInoremap=1

"quick command to open and source my vimrc file
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
"
"""""""""""""" Abbreviations """""""""""""""" 
"typos and shortcuts
iabbrev adn and
iabbrev waht what
iabbrev tehn then
iabbrev vra var
augroup abbrev
    autocmd!
    autocmd FileType vim iabbrev "" "--------------------------------------------- {{{<CR>}}}<CR>

    autocmd FileType go iabbrev se select
    autocmd FileType go iabbrev td //TODO (minzhang): 
augroup END

nnoremap <Leader><Space> :match ErrorMsg /\s\+$/ <cr>
nnoremap <Leader>c<Space> :match none <cr>

func Showhighlight()
    execute ":source $VIMRUNTIME/syntax/hitest.vim"
endfunction
