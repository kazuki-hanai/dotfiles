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
