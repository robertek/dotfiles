syntax on
set mouse=ni
set t_Co=256
set background=dark
colorscheme desert256

set backspace=indent,eol,start

set smartcase
set showcmd
set ts=2
set cindent
set sw=2
set incsearch
set nu
set history=1000
set autoread
set foldmethod=manual

set cm=blowfish

set thesaurus+=~/.vim/mthesaur.txt

set hidden

filetype plugin on
filetype indent on
let g:tex_flavor='latex'
set grepprg=grep\ -nH\ $*
set iskeyword+=:

" Append modeline after last line in buffer.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d :",
        \ &tabstop, &shiftwidth)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
