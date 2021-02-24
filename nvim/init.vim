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

" dein settings
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif
if has('vim_starting') && dein#check_install()
  call dein#install()
endif

" ctags setting
autocmd BufNewFile,BufRead * source ~/.config/nvim/ctags.vim

" cscope
autocmd BufNewFile,BufRead * source ~/.config/nvim/cscope.vim

" auto complete
autocmd BufNewFile,BufRead * source ~/.config/nvim/auto.vim

" c/c++ completion
" autocmd BufNewFile,BufRead * source ~/.config/nvim/c_completion.vim

" colorscheme
colorscheme base16-default-dark

syntax on
