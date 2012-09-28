syntax on
set mouse=ni
set t_Co=256
colorscheme anotherdark

set backspace=indent,eol,start

set nowrap
set smartcase
set showcmd
set ts=2
set cindent
set sw=2
"set expandtab
set incsearch
set nu
set history=1000
set autoread

filetype plugin on
filetype indent on
let g:tex_flavor='latex'

" Append modeline after last line in buffer.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d :",
        \ &tabstop, &shiftwidth)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
