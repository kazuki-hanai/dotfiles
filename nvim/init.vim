set clipboard+=unnamedplus
set hls
set number
set title
set ambiwidth=double
set expandtab
set tabstop=8
filetype on
filetype plugin indent on
set shiftwidth=4
set nrformats-=octal
set hidden
set history=50
set wrapscan
set virtualedit=block
set whichwrap=b,s,[,],<,>
set backspace=indent,eol,start
set wildmenu
set noswapfile
set autoread
set tags=<tags_path>

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
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

set fileformats=unix,dos,mac
set fileencodings=utf-8
set termguicolors
set ambiwidth=double
syntax on
colorscheme desert

if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

"{{{
" vim-plug
call plug#begin(stdpath('data') . '/plugged')
" nerdtree
Plug 'scrooloose/nerdtree'
" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" autopairs
Plug 'jiangmiao/auto-pairs'
" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
"}}}

" {{{
" fzf
command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always --smart-case '. <q-args>, 1,
    \ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
    \ : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%', '?'),
    \ <bang>0)
let g:rg_derive_root='true'
nnoremap <C-s> :Rg<Space>
nnoremap <C-p> :GFiles<CR>
" nnoremap <C-h> :History<CR>
nnoremap <Leader>b :Buffers<cr>
nnoremap <Leader>s :BLines<cr>
" }}}
