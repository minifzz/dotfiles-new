" BEGIN OF Vundle
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
Plugin 'vim-scripts/a.vim'
Plugin 'mhinz/vim-startify' 
Plugin 'Valloric/YouCompleteMe'

" ----- Working with Git ----------------------------------------------
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'zivyangll/git-blame.vim'

"Plugin 'wakatime/vim-wakatime'  " productivity tracker
" Snippets
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

" ----- Plugin-Specific Settings --------------------------------------
" ----- altercation/vim-colors-solarized settings -----
" Set the colorscheme
colorscheme solarized
set background=dark

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
nmap <silent> <S-t> :NERDTreeTabsToggle<CR>
" To have NERDTree always open on startup
let g:nerdtree_tabs_open_on_console_startup = 0
" END OF plugin setups
"
" ----- startify do not change diretory
let g:startify_change_to_dir = 0

" ----- scrooloose/syntastic settings -----
let g:syntastic_python_checkers = ['python']
let g:syntastic_coffee_checkers = ['coffeelint', 'coffee']
let g:syntastic_go_checkers = []
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-", "trimming empty"]
let g:syntastic_mode_map = { "mode": "passive", "active_filetypes": ["python"], "passive_filetypes":["go"] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list = 0

let g:syntastic_error_symbol = '✘' "keeping them for ycm
let g:syntastic_warning_symbol = "▲" "keeping them for ycm

" ----- airblade/vim-gitgutter settings -----
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1
nnoremap <Leader>gb :Gblame<CR>  " git blame
"nmap <Leader>s :GitGutterToggle<CR> 

let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'
let g:gitgutter_override_sign_column_highlight = 1
highlight SignColumn guibg=bg ctermbg=bg
set updatetime=100
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>

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
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
" disable ycm autoconfirmation
let g:ycm_confirm_extra_conf = 0
" get identifiers from tag files
let g:ycm_collect_identifiers_from_tags_files = 1
nmap <leader>D <plug>(YCMHover)
let g:ycm_error_symbol = '✘'
let g:ycm_warning_symbol = "▲"
" disable the auto hover
let g:ycm_auto_hover=''
" add mapping to manually trigger or hide the popup
nmap <S-k> <plug>(YCMHover)
" let g:ycm_always_populate_location_list = 1

" use ycm's goto def, instead of vim's default
" nnoremap gd :YcmCompleter GoTo<CR>
" nnoremap gr :YcmCompleter GoToReferences<CR>
" nnoremap gl :YcmCompleter FixIt<CR>

" ---- Supertab settings ----
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" ---- General settings ---
set showcmd "show partial commands
set hls "highlight searches
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

"Code folding
set foldmethod=indent
set foldlevel=99

"Set hybrid line numbering and autotoggle
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
" set cursorline

"Mappings

let mapleader = ","

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

""Use Ctrl-a and Ctrl-e to jump to start/end of lines, like Emacs
imap <C-a> <Esc>^i
imap <C-e> <Esc>$a

"Use Ctrl-a to select all
map <C-a> ggVG

"Up and down arrows use screen lines
map <Up> gk
map <Down> gj
imap <Up> <Esc>gka
imap <Down> <Esc>gja

imap jk <Esc>

"Y copies until end of line
map Y y$

"Split window
map - :sp<CR>
map _ :vsp<CR>

"Switch between windows
map <Tab> <C-w>w
map <S-Tab> <C-w>W

"Select within $ for Latex
map ci$ T$ct$
map di$ T$dt$

"Tab commands
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
"nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>
" Alternatively use
"nnoremap th :tabnext<CR>
"nnoremap tl :tabprev<CR>
nnoremap tn :tabnew<CR>
nnoremap :te :tabe<Space>

" Navigating location list (errors)
nnoremap lj :lnext<CR>
nnoremap lk :lprevious<CR>

" Jump to next error with Ctrl-n and previous error with Ctrl-m. Close the
" quickfix window with <leader>a
map <C-n> :cnext<CR>
map <C-b> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" Visual linewise up and down by default (and use gj gk to go quicker)
noremap <Up> gk
noremap <Down> gj
noremap j gj
noremap k gk

"gdb
map :gdb :ConqueGdb
map :gdbs :ConqueGdbSplit
map :gdbvs :ConqueGdbVSplit

"freeze vim latex auto insert
let g:Imap_FreezeImap=1
