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

