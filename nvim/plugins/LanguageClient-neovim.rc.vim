set hidden

" settings for languages
let g:LanguageClient_serverCommands = {
        \ 'c': ['clangd'],
        \ 'cpp': ['clangd'],
        \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
        \ }

augroup LanguageClient_config
autocmd!
autocmd User LanguageClientStarted setlocal signcolumn=yes
autocmd User LanguageClientStopped setlocal signcolumn=auto
augroup END

let g:LanguageClient_autoStart = 1
nnoremap <silent> <Space>lh :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> <Space>ld :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <Space>lr :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> <Space>lf :call LanguageClient_textDocument_formatting()<CR>
