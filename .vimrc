" ============================================================================
" Vundle initialization
" Avoid modify this section, unless you are very sure of what you are doing
" =============================================================================

" be iMproved, required
set nocompatible

" required
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" this line goes before Plugin definitions
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" plugins on github repos -----------------------------------------------------

" Color scheme
Plugin 'tomasr/molokai'

" Code and files fuzzy finder
Plugin 'kien/ctrlp.vim'

" Code commenter
Plugin 'scrooloose/nerdcommenter'

" Better file browser
Plugin 'scrooloose/nerdtree'

" Class outline viewer
Plugin 'majutsushi/tagbar'

" Syntax checker / linter
"Plugin 'scrooloose/syntastic'

" Lean & mean status/tabline
Plugin 'bling/vim-airline'

" Snippets engine (require python support)
Plugin 'SirVer/ultisnips'

" Snippets for many languages
Plugin 'honza/vim-snippets'

" Trailing whitespaces solution
Plugin 'ntpeters/vim-better-whitespace'

" Sublime Text style multiple selections
Plugin 'terryma/vim-multiple-cursors'

" Golang support
Plugin 'fatih/vim-go'


" this line goes after Plugin definitions
call vundle#end()

" allow plugins by file type (required for plugins!)
filetype plugin on
filetype indent on

" ============================================================================
" Vim settings and mappings
" =============================================================================

set title

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent

" terminal vim with 256 colors
set t_Co=256

" default sublime colorscheme
"colorscheme molokai
colorscheme elflord
"colorscheme ron

" highlight the current line
set cursorline

" incremental search
set incsearch

" highlighted search results
set hlsearch

" syntax highlight on
syntax on

" no wrap lines
set nowrap

" display line numbers
set number

" display relative line numbers
set norelativenumber

" always show status bar
set ls=2

" open more than 10 tabs
set tabpagemax=999

" leader mapping
let mapleader=","

" ignore case when searching
set ignorecase

" ignore case if search pattern is all lowercase, case-sensitive otherwise
set smartcase

" use multiple of shiftwidth when indenting with '<' and '>'
set shiftround

" new horizontal split are created below the actual
set splitbelow
set splitright

" when scrolling, keep the cursor 3 lines away from screen border
set scrolloff=3

" tab navigation mappings
map tn :tabn<CR>
map tp :tabp<CR>
map <C-S-l> :tabn<CR>
imap <C-S-l> <ESC>:tabn<CR>
map <C-S-h> :tabp<CR>
imap <C-S-h> <ESC>:tabp<CR>
map tm :tabm
map tt :tabnew
map ts :tab split<CR>




" simple recursive grep
" both recursive grep commands with internal or external (fast) grep
command! -nargs=1 RecurGrep lvimgrep /<args>/gj ./**/*.* | lopen | set nowrap
command! -nargs=1 RecurGrepFast silent exec 'lgrep! <q-args> ./**/*.*' | lopen
" mappings to call them
nmap ,R :RecurGrep
nmap ,r :RecurGrepFast





" better backup, swap and undos storage
set directory=~/.vim/dirs/tmp " directory to place swap files in
set backup " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo

" store yankring history file there too
let g:yankring_history_dir = '~/.vim/dirs/'

" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

" add path for ctrlp plugin
set runtimepath^=~/.vim/bundle/ctrlp

" =============================================================================
" Plugins settings and mappings
" =============================================================================

" Ctrlp -----------------------------------------------------------------------

let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_clear_cache_on_exit=0
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" more results
"let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'

" NERDTree --------------------------------------------------------------------

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = []

" tagbar ----------------------------------------------------------------------
nmap <F8> :TagbarOpenAutoClose<CR>

" syntastic -------------------------------------------------------------------
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" ultisnips -------------------------------------------------------------------

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" =============================================================================
" Filetypes
" =============================================================================

au BufRead,BufNewFile *.md set filetype=markdown

" =============================================================================
" Functions
" =============================================================================

function! GetVisualSelection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]

  return join(lines, "\n")
endfunction

function! DatabaseQuery() range
    let sql = GetVisualSelection()
    let output = system('db query "' . sql . '" --no-ansi')

    split DatabaseQueryOutput
    setlocal buftype=nofile

    normal! ggdG
    call append(0, split(output, '\v\n'))
    normal! gg
endfunction

" =============================================================================
" Mappings
" =============================================================================

vmap ,q :call DatabaseQuery()<CR>
