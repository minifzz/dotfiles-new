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
"Plugin 'vim-syntastic/syntastic'
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

" ----- scrooloose/syntastic settings -----
let g:syntastic_check_on_open = 0
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END

" ----- airblade/vim-gitgutter settings -----
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1
nnoremap <Leader>gb :Gblame<CR>  " git blame
nmap <Leader>s :GitGutterToggle<CR> 

let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'
let g:gitgutter_override_sign_column_highlight = 1
highlight SignColumn guibg=bg ctermbg=bg
set updatetime=100

" --- General settings ---
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
map <S-n> :tabnew<CR>
map <S-Left> gT
map <S-Right> gt
map <S-x> :tabclose<CR>
map <S-c> :tabonly<CR>
map <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
map <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

"gdb
map :gdb :ConqueGdb
map :gdbs :ConqueGdbSplit
map :gdbvs :ConqueGdbVSplit

"freeze vim latex auto insert
let g:Imap_FreezeImap=1
