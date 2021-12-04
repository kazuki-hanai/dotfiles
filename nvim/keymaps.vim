" common keymap
inoremap <S-Tab> <C-d>

" Tab mappings
nnoremap <C-t> :tabnew<CR>
nnoremap <C-l> :tabnext<CR>
nnoremap <C-h> :tabprevious<CR>
nnoremap tl :+tabmove<CR>
nnoremap th :-tabmove<CR>
inoremap <C-t> <Esc>:tabnew<CR>i
inoremap <C-l> <Esc>:tabnext<CR>i
inoremap <C-h> <Esc>:tabprevious<CR>i
nnoremap tl :+tabmove<CR>
nnoremap th :-tabmove<CR>
nnoremap tt  :tabedit<Space>
nnoremap td  :tabclose<CR>

