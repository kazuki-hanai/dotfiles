" {{{ color
" Define mythemes
let g:mythemes = {
\  0: 'default',
\  1: 'iceberg',
\  2: 'ayu',
\  3: 'falcon',
\  4: 'tender',
\  5: 'gruvbox',
\  6: 'monokai-phoenix',
\  }
let g:mythemes_status = 0

" Change Color Scheme
function! s:changeColorScheme(themeno)
  let themeno = a:themeno
  if has_key(g:mythemes, themeno)
    let theme = get(g:mythemes, themeno)
  else
    let theme = themeno
  endif
  echo theme
  if strlen(theme) != 0
    execute 'colorscheme ' . theme
  endif
  " ---------------------"
  " Fix wacky highlights "
  " ---------------------"
  highlight Pmenu guibg=#300000
  highlight FgCocErrorFloatBgCocFloating guibg=#300000
  highlight SignColumn guibg=default
  " {{{ vim-gitgutter
  highlight GitGutterAdd    guifg=#00E157 guibg=default ctermfg=2
  highlight GitGutterChange guifg=#FFBF00 guibg=default ctermfg=3
  highlight GitGutterDelete guifg=#FF2222 guibg=default ctermfg=1
  " }}} vim-gitgutoer
endfunction

" Toggle colorscheme
function s:toggleColorScheme()
  let themes_len = len(keys(g:mythemes))
  let g:mythemes_status = (g:mythemes_status + 1) % themes_len
  call s:changeColorScheme(g:mythemes_status)
endfunction

command! -nargs=1 ChangeColorScheme :call s:changeColorScheme(<q-args>)
command! -nargs=1 ToggleColorScheme :call s:toggleColorScheme()
noremap <C-c> :ToggleColorScheme()<CR>

call s:changeColorScheme(g:mythemes_status)
" colorscheme molokai
" colorscheme gobo
" }}} color
