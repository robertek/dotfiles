" style
syntax on
filetype plugin on
filetype indent on
set t_Co=256

" behavior
set mouse=ni
set hidden
set showcmd
set foldmethod=manual
set history=1000
set nu
set incsearch
set autoread
set backspace=indent,eol,start
set smartcase

" writing and indent
set cindent
set sw=8
set ts=8
set sts=8
set textwidth=80
set noexpandtab
set cinoptions=t0,(.5s,u0,:0,+.5s

" 80 char border
set colorcolumn=81
hi ColorColumn ctermbg=darkgrey guibg=grey50

" file encryption
set cm=blowfish

" plugins, latex
let g:tex_flavor='latex'
set grepprg=grep\ -nH\ $*
set iskeyword+=:
set thesaurus+=~/.vim/mthesaur.txt

" set status line
set laststatus=2
let g:airline_theme = "wombat"
