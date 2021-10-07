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
set noexpandtab

" 80 char border
set colorcolumn=81
hi ColorColumn ctermbg=grey guibg=grey50

" load pathogen and it plugins
execute pathogen#infect()

" plugins
set thesaurus+=~/.vim/mthesaur.txt

" set status line
set laststatus=2

" enable rainbow plugin
let g:rainbow_active = 1

" async update
set updatetime=100

" gvim
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
highlight Normal guifg=white guibg=black

if filereadable("/opt/onbld/etc/vim/cstyle.vim")
      :source /opt/onbld/etc/vim/cstyle.vim
endif

if filereadable("/opt/onbld/etc/vim/cscope.vim")
      :source /opt/onbld/etc/vim/cscope.vim
endif
