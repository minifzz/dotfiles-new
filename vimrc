" BEGIN OF Vundle

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim' " Vundle dogfooding itself, required

Plugin 'wakatime/vim-wakatime'  " productivity tracker
Plugin 'tpope/vim-fugitive'     " powerful git tool
Plugin 'kien/ctrlp.vim'         " textmate-like ctrl+p hotkey
" Snippets
Plugin 'SirVer/ultisnips'
Plugin 'msanders/snipmate.vim'
" Plugin 'honza/vim-snippets'

Plugin 'rhysd/vim-clang-format'

Plugin 'rizzatti/dash.vim'
Plugin 'bling/vim-airline'
Plugin 'edkolev/tmuxline.vim'

Plugin 'flazz/vim-colorschemes'
Plugin 'altercation/vim-colors-solarized'

Plugin 'airblade/vim-gitgutter' " git diff
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" END OF Vundle
syntax enable
set background=dark
"colorscheme solarized
colorscheme Monokai
colorscheme molokai

set autowrite                  " Writes on make/shell commands
set autoread
set backspace=2           " Allow backspacing over indents, line breaks, and start of insert

" 81 character line
if exists("+colorcolumn")
    set colorcolumn=81
endif

" Visual "{{{
syntax on                      " enable syntax

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

set mousehide                 " Hide mouse after chars typed

set showmatch                 " Show matching brackets.

set wildmode=longest,list     " At command line, complete longest common string, then list alternatives.

set completeopt+=preview

set novisualbell              " No blinking
set noerrorbells              " No noise.
set vb t_vb=                  " disable any beeps or flashes on error

set shortmess+=atI             " shortens messages

set foldenable                " Turn on folding
set foldmethod=marker         " Fold on the marker
set foldlevel=100             " Don't autofold anything (but I can still fold manually)

set foldopen=block,hor,tag    " what movements open folds
set foldopen+=percent,mark
set foldopen+=quickfix

set virtualedit=block

set splitbelow
set splitright

set list                      " display unprintable characters f12 - switches
set listchars=tab:\ ·,trail:·
set listchars+=extends:»,precedes:«
map <silent> <F12> :set invlist<CR>

" "}}}

"let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py" "for ycm

let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

" powerline symbols
let g:airline_symbols = {}

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" old stuff from pnaimoli

let $VIMRC = '~/.vimrc'   " for portability

filetype on               " enable filetype detection

set hid                   " don't auto-remove hidden buffers
set history=1000          " 50 commands stored in history
set hlsearch              " highlight all search pattern matches
set incsearch             " incremental search
set isk+=%,#              " none of these should be word dividers
set linebreak             " enable smart linebreaking
set matchtime=0           " prevent matching delay
set ic                    " force case-sensitive
set nu                    " show line numbers
set scrolloff=2           " keep 2 lives visible above/below the cursor
set laststatus=2          " always show status line.
set shortmess+=IA         " suppress intro and swap file messages
set showcmd               " show command on last line
set showmode              " show mode
set smartcase             " overrides ignorecase if uppercase used
set wig=*.o,*.pyc         " Ignore these files for wildmenu completion
set wildmenu              " Better command-line completion
set wildmode=longest:full " Makes tab completion smarter
set winheight=3           " Never let a window be less than 3 lines
set winminheight=3        " Never let a window be less than 3 lines

set autoindent            " indent like the last line, by default
set cindent               " indent for c syntax
set cinkeys-=0#           " I should look up what this does again
set cinoptions+=g2        " indent scope declarations by 2
set cinoptions+=h2        " indent statements after scope declarations by 2
set expandtab             " expand tabs to spaces
set shiftwidth=4          " basic indents = 4 spaces
set smarttab              " delete shifted spaces as if they were tabs
set tabstop=4             " tabs = 4 spaces
set paste

""""""""""""""""""""""""""""""""""
" ===== Auto command section =====
""""""""""""""""""""""""""""""""""
if has('autocmd')
    augroup vimrc
    au!
    " Set up CPP specific autocommands
    au FileType c,cpp,cc setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,f://

    au BufNewFile,BufRead *.{c,cpp,cc,cxx,h}        set ft=cpp
    au BufNewFile,BufRead *.{sig,cnf,conf,config}   set ft=config
    au BufNewFile,BufRead *.slaqur                  set filetype=yaml

    " When entering a buffer, cd to the file's directory
    autocmd BufEnter * :cd %:p:h

    " Auto source the vimrc file when it is saved
    au! BufWritePost [\._]vimrc source $VIMRC

    augroup END
endif

""""""""""""""""""""""""""""""""""
" ===== Fast Window Resizing =====
""""""""""""""""""""""""""""""""""
nmap + <C-W>+
nmap - <C-W>-

"""""""""""""""""""""""""""""""
" ===== Nice Window Title =====
"""""""""""""""""""""""""""""""
if has('title') && (has('gui_running') || &title)
    set titlestring=
    set titlestring+=%f\                                              " file name
    set titlestring+=%h%m%r%w                                         " flags
    set titlestring+=\ -\ %{v:progname}                               " program name
    set titlestring+=\ -\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}  " working directory
endif

""""""""""""""""""""""""""""""""""""""""""""""""""
" ===== TODO: Organize this at a later point =====
""""""""""""""""""""""""""""""""""""""""""""""""""
" switch between .h and .cc file Easily
let g:alternateExtensions_cc = "he,h"
let g:alternateExtensions_h = "cc,c"
let g:alternateExtensions_he = "cc,c"
let g:alternateRelativeFiles = 1
map <F2> :A<CR>

" super paste
"inoremap <C-V> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>
vnoremap <S-C> "+y

" Set up directories to search when cd'ing
set cdpath=.,$HOME,$HOME/atl,$HOME/atl/src,/,/home

"Set up path to search for .h files
set path=.,$HOME/projects/atl/src,$HOME/projects/atl/fbsd7/include,$HOME/projects/atrade/src

" Load filetype plugins
filetype plugin on

" Also, set our tags path to be useful
" find projects/atl/src projects/btrade/src -name "*.cc" -print -or -name "*.h" -print | etags -
set tags=$HOME/.TAGS

" easy key to pop back from looking at a tag
" noremap <silent> <C-[> :pop<CR>

" set up align =
nmap ,= :Align =<CR>
vmap ,= :Align =<CR>

set encoding=utf-8
set guifont=Monaco\ for\ Powerline:h15

""""""""""""""""""""""""""""""""""
" ===== Edit & Reload .vimrc =====
""""""""""""""""""""""""""""""""""
nmap ,s :source $VIMRC
nmap ,e :e $VIMRC

""""""""""""""""""""""""""""""""""
" ===== Windows Style Saving =====
""""""""""""""""""""""""""""""""""
map <silent> <C-S> :if expand("%") == ""<CR>:browse confirm w<CR>:else<CR>:confirm w<CR>:endif<CR>
imap <c-s> <c-o><c-s>

""""""""""""""""""""""""""""
" ===== Switching tabs =====
""""""""""""""""""""""""""""
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l

"""""""""""""""""""""""""""""""""""""""""
" ===== Alternative navigation keys =====
"""""""""""""""""""""""""""""""""""""""""
set whichwrap+=<,>,[,]
map j gj
map k gk

map <up> gk
imap <up> <C-O><up>
map <down> gj
imap <down> <C-O><down>

""""""""""""""""""""""""""""""""""
" ===== Commenting utilities =====
"""""""""""""""""""""""""""""""""

let mapleader=' '

map <silent> <leader>a :noh<CR>

fun! s:CoolComment(chars)
    let @@=@/
    exe "s@^@".a:chars."@"
    let @/=@@
endfun

fun! s:ClearComment()
    let @@=@/
    try
        exe "s@^//\\|^--\\|^> \\|^[#\"%!;]@@"
    catch
    endtry
    let @/=@@
endfun

map <silent> <leader># :call <SID>CoolComment("#")<CR>
map <silent> <leader>" :call <SID>CoolComment("\"")<CR>
map <silent> <leader>/ :call <SID>CoolComment("//")<CR>
map <silent> <leader>c :call <SID>ClearComment()<CR>


"""""""""""""""""""""""""""""""""""""
" ====== Smart home navigation ======
"""""""""""""""""""""""""""""""""""""
fun! s:SmartHome()
    if col('.') != match(getline('.'), '\S')+1
        norm g^
    else
        norm g0
    endif
endfun
noremap <silent> <home> :call <SID>SmartHome()<CR>
imap <home> <C-O><home>

"""""""""""""""""""""""""""""""""""""""""""""
" ===== To save current state on exit ===== "
"""""""""""""""""""""""""""""""""""""""""""""
"au vimrc BufWinLeave ?* mkview
"au vimrc BufWinEnter ?* silent loadview

""""""""""""""""""""""""""""""
" ====== PLUGIN OPTIONS ======
""""""""""""""""""""""""""""""

" === SyntaxAttr === "
noremap ,a :call SyntaxAttr()<CR>

" === Rainbow Parenthesis === "
command! Rain :call rainbow_parenthesis#Toggle()

" === SuperTab
" http://www.vim.org/scripts/script.php?script_id=1643
" Use the tab key to do insert completion
" let g:SuperTabDefaultCompletionTypeDiscovery = "&omnifunc:<C-X><C-O>,&completefunc:<C-X><C-U>"

" === OmniCppComplete
" http://www.vim.org/scripts/script.php?script_id=1520
" Complete symbol names using tags database
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

nnoremap ; :
nnoremap Y y$
vnoremap < <gv
vnoremap > >gv
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap ]] ]]zz
nnoremap [[ [[zz
nnoremap } }zz
nnoremap { {zz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

" When we replace the selected text xyz123 with our previous yanked text
" abc456, the "+ register will hold abc456 after the replacement. So if we want 
" to replace many different stuff with xyz123, we should store it in another
" register. That's why we use the register "o in the following four lines.
nnoremap <F4> "oyiw
vnoremap <F4> "oy
nnoremap <F5> viw"op
vnoremap <F5> "op
