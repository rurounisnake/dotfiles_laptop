" Change cursor shape between insert and normal mode in kitty
if &term =~ 'kitty'
  let &t_SI = "\<Esc>[6 q" " Insert mode: Beam
  let &t_SR = "\<Esc>[4 q" " Replace mode: Underline
  let &t_EI = "\<Esc>[2 q" " Normal mode: Block
endif

syntax on

let mapleader=" "


set number relativenumber
set ignorecase
set smartcase
set incsearch
set termguicolors

"Split Line in Normal mode
nnoremap <Enter> i<Enter><Esc>k$

"system clipboard
vmap <leader>y "*y
vmap <leader>d "*d
nmap <leader>y "*yy
nmap <leader>p "*p
nmap <leader>P "*P
vmap <leader>p "*p
vmap <leader>P "*P
