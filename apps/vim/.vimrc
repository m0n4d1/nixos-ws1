"GENERAL
set updatetime=100
set nocompatible
syntax on
filetype plugin indent on
set encoding=utf8
set expandtab
set shiftwidth=2
set softtabstop=2
set relativenumber

"NERDTREE
nmap <F6> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden=1

"AIRLINE
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '▕'
let g:airline_theme='onedark'

"STYLING
colo one
"set termguicolors
set background=dark
set term=xterm-termite
set t_Co=256
set fillchars+=vert:\ 
hi VertSplit guibg='#2c323c' guifg='#2c323c'
hi NonText guibg='#2c323c' guifg='#2c323c'
hi CursorLine guibg='#2c323c'

"INDENTLINE
let g:indentLine_char = '▏'
let g:indentLine_color_gui = "#4b5263"
let g:indentLine_color_dark = 1 

"ALE
let b:ale_fixers = ['prettier', 'eslint']
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_completion_enabled = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
