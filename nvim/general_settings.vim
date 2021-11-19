set encoding=utf-8
set clipboard+=unnamedplus
set hls
set number
set title
set ambiwidth=double
set expandtab
set tabstop=8
set shiftwidth=2
set nrformats-=octal
set hidden
set history=50
set wrapscan
set virtualedit=block
set whichwrap=b,s,[,],<,>
set backspace=indent,eol,start
set wildmenu
set nobackup
set nowritebackup
set noswapfile
set autoread
set tags=<tags_path>
set cmdheight=2
set updatetime=300
set shortmess+=c
filetype on
filetype plugin indent on

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" common keymap
inoremap <S-Tab> <C-d>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
nnoremap <C-t> :tabnew<CR>
nnoremap <C-l> :tabnext<CR>
nnoremap <C-h> :tabprevious<CR>
nnoremap tl :+tabmove<CR>
nnoremap th :-tabmove<CR>
inoremap <C-t> <Esc>:tabnew<CR>i
inoremap <C-l> <Esc>:tabnext<CR>i
inoremap <C-h> <Esc>:tabprevious<CR>i
nnoremap tt  :tabedit<Space>
nnoremap td  :tabclose<CR>

" lasttab
if !exists('g:lasttab')
  let g:lasttab = 1
endif
" nmap <C-a> :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

set fileformats=unix,dos,mac
set fileencodings=utf-8
set termguicolors
set ambiwidth=double
syntax on
" colorscheme desert

if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END