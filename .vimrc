set nocompatible
set bg=dark

syntax enable

"Indenting is 4 spaces not 8, do not use tab char
set shiftwidth=4
set softtabstop=4
set expandtab
set backspace=indent,eol,start

"Very cool relative line numbering
set relativenumber

"Insensitive case search except when explicitly using caps
set ignorecase
set smartcase

set hidden "Allows switching buffer without writing to disk

"Use to prevent searching of some files: TODO: customize
"set wildignore+=

let g:netrw_banner = 0 "No header spam in directory mode

let g:netrw_liststyle=3 "Tree style

set shell=/bin/bash

" Change vim cursor to work in microsoft terminal
" https://vim.fandom.com/wiki/Configuring_the_cursor
" 1 or 0 -> blinking block
" 2 solid block
" 3 -> blinking underscore
" 4 solid underscore
" Recent versions of xterm (282 or above) also support
" 5 -> blinking vertical bar
" 6 -> solid vertical bar

if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[2 q"
endif

if (&term =~ '^xterm' && &t_Co == 256)
  set t_ut= | set ttyscroll=1
endif

" Install node if it doesn't exist (used for plugs)
" curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

"Setup vim plug if it doesn't already exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Plugs
call plug#begin()
Plug 'lifepillar/vim-solarized8'
"osc52 yanking
Plug 'ojroques/vim-oscyank'
Plug 'https://github.com/vim-syntastic/syntastic.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'puremourning/vimspector'
Plug 'jeetsukumaran/vim-buffergator'
call plug#end()

" syntastic
let g:syntastic_cs_checkers = ['code_checker']

" Copy yank buffer to system clipboard
" Use osc52 to put things into the system clipboard, works over ssh
" Replaced with plug from https://github.com/ojroques/vim-oscyank
augroup YankOSC52
autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | :call YankOSC52(getreg('"')) | endif
augroup END

function! NumberToggle()
    if(&rnu == 1)
        set nornu
    else
        set rnu
    endif
endfunction
nnoremap <C-n> :call NumberToggle()<CR>

ino <C-A> <C-O>yiW<End>=<C-R>=<C-R>0<CR>

"Note: If there are errors try :set shell=/bin/bash
"Note: Important that you include the . after %!jq

command! JSON setlocal filetype=json | %!jq . 

"Decreases the amount of time VIM waits to see if the terminal will use an escape sequence. Speeds up <esc>O usage
set ttimeoutlen=10
"colorscheme solarized8_high
colorscheme default

