" turn off compatibility with vi
set nocompatible

" Each time a new or existing file is edited, Vim will try to recognize the
" type of the file and set the 'filetype' option. This will trigger the
" FileType event, which can be used to set the syntax highlighting, set
" options, etc.
filetype on

" When a file is edited its plugin file is loaded (if there is one for the
" detected filetype).
filetype plugin on

" When a file is edited its indent file is loaded (if there is one for the
" detected filetype).
filetype indent on

" When on, the title of the window will be set to the value of 'titlestring'
" (if it is not empty), or to: filename [+=-] (path) - VIM
set title

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent

" terminal vim with 256 colors
set t_Co=256

" color palette
colorscheme elflord

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

" better backup, swap and undos storage

" directory to place swap files in
set directory=~/.vim/dirs/tmp 

" make backup files
set backup

" where to put backup files
set backupdir=~/.vim/dirs/backups

" persistent undos - undo after you re-open the file
set undofile

" where to put undo files
set undodir=~/.vim/dirs/undos

set viminfo+=n~/.vim/dirs/viminfo

" create needed directories if they don't exist

if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif

if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif

if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

" Filetypes

au BufRead,BufNewFile *.md set filetype=markdown
