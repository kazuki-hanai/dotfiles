set encoding=utf-8
set clipboard+=unnamedplus
set hls
set number
set title
set ambiwidth=double
set expandtab
set tabstop=8
filetype on
filetype plugin indent on
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

" {{{ vim-plug
call plug#begin(stdpath('data') . '/plugged')
Plug 'scrooloose/nerdtree'
Plug 'yggdroot/indentline'
Plug 'luochen1990/rainbow'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'flazz/vim-colorschemes'
Plug 'simeji/winresizer'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'tomlion/vim-solidity'
call plug#end()
" }}} vim-plug

" {{{ coc plugins
let g:coc_global_extensions = [
    \  'coc-tsserver'
    \, 'coc-snippets'
    \, 'coc-prettier'
    \, 'coc-eslint'
    \, 'coc-vetur'
    \, 'coc-pairs'
    \, 'coc-fzf-preview'
    \, 'coc-explorer'
    \, 'coc-rust-analyzer'
    \, 'coc-yaml'
    \, 'coc-json'
    \, 'coc-python'
    \, 'coc-styled-components'
    \, 'coc-go'
    \, 'coc-cmake'
\, ]
" }}} coc plugins

" {{{ nerdtree
nnoremap <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
" }}} nerdtree

" {{{ indentline
let g:indentLine_enabled = 1
autocmd Filetype json let g:indentLine_enabled = 0
let g:vim_json_syntax_conceal = 0
" }}} indentline

" {{{ luochen1990/rainbow
" set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_active = 1
" }}} luochen1990/rainbow

" {{{ lightline
function! LightlineFilename()
  " If winwidth is small, return only filename not 
  " included whole path.
  if winwidth(0) < 80
    return expand('%:t')
  else
    let root = fnamemodify(get(b:, 'git_dir'), ':h')
    let path = expand('%:p')
    if path[:len(root)-1] ==# root
      return path[len(root)+1:]
    endif
    return expand('%')
  endif
endfunction

function! GitStatus()
  " If winwidth is small, this function doesn't return
  " any string
  if winwidth(0) < 80
    return printf('%s', fugitive#head())
  else
    let [a,m,r] = GitGutterGetHunkSummary()
    return printf('%s +%d ~%d -%d', fugitive#head(), a, m, r)
  endif
endfunction

function! ModeMap()
  if winwidth(0) < 80
    let mode_map = {
    \ 'n' : 'N',
    \ 'i' : 'I',
    \ 'R' : 'R',
    \ 'v' : 'V',
    \ 'V' : 'VL',
    \ "\<C-v>": 'VB',
    \ 'c' : 'C',
    \ 's' : 'S',
    \ 'S' : 'SL',
    \ "\<C-s>": 'SB',
    \ 't': 'T',
    \ }
  else
    let mode_map = {
    \ 'n' : 'NORMAL',
    \ 'i' : 'INSERT',
    \ 'R' : 'REPLACE',
    \ 'v' : 'VISUAL',
    \ 'V' : 'V-LINE',
    \ "\<C-v>": 'V-BLOCK',
    \ 'c' : 'COMMAND',
    \ 's' : 'SELECT',
    \ 'S' : 'S-LINE',
    \ "\<C-s>": 'S-BLOCK',
    \ 't': 'TERMINAL',
    \ }
  endif
  return mode_map
endfunction

let g:lightline = {
\   'mode_map': ModeMap(),
\   'active': {
\     'left':[ [ 'mode', 'paste' ],
\              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
\     ]
\   },
\   'component': {
\     'lineinfo': ' %3l:%-2v',
\   },
\   'component_function': {
\     'gitbranch': 'GitStatus',
\     'filename': 'LightlineFilename',
\   },
\ }
" }}} lightline

" {{{ vim-gitgutter
highlight GitGutterAdd    guifg=#00E157 ctermfg=2 guibg=default
highlight GitGutterChange guifg=#FFBF00 ctermfg=3 guibg=default
highlight GitGutterDelete guifg=#FF2222 ctermfg=1 guibg=default
" }}} vim-gitgutter

" {{{ fzf
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
" }}} fzf

" {{{ vim-jsx-typescript
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
" }}} vim-jsx-typescript

" {{{ coc.nvim
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
" nmap <silent> <C-a> <Plug>(coc-range-select)
" xmap <silent> <C-a> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" let g:lightline = {
"     \ 'active': {
"     \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ],
"     \ }
" \ }

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR> 
" }}} coc.nvim

" {{{ Coc plugins
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" }}} Coc plugins

" {{{ color
function! ChangeColorScheme(theme)
  let theme = a:theme
  echo theme
  if strlen(theme) != 0
    execute 'colorscheme ' . a:theme
  endif
  highlight Pmenu guibg=#300000
  highlight FgCocErrorFloatBgCocFloating guibg=#300000
  highlight SignColumn guibg=default
  " {{{ vim-gitgutter
  highlight GitGutterAdd    guifg=#00E157 guibg=default ctermfg=2
  highlight GitGutterChange guifg=#FFBF00 guibg=default ctermfg=3
  highlight GitGutterDelete guifg=#FF2222 guibg=default ctermfg=1
  " }}} vim-gitgutter
endfunction
command! -nargs=1 ChangeColorScheme :call ChangeColorScheme(<args>)

call ChangeColorScheme("")
" colorscheme molokai
" colorscheme gobo
" }}} color
