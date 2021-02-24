set tags=.tags;~
nnoremap <silent> <C-K><C-T> :TagbarToggle<CR>
nnoremap <C-j> g<C-j>

" import ctags and create ctags file when there is no ctags file.
function! s:execute_ctags() abort
    let tag_name = '.tags'
    let tags_path = findfile(tag_name, '.;')
    if tags_path ==# ''
        return
    endif

    let tags_dirpath = fnamemodify(tags_path, ':p:h')
    execute 'silent !cd' tags_dirpath '&& ctags -R - --format=2 --excmd=pattern --extras= --fields=nksaSmt -f ' tag_name '2> /dev/null &'
endfunction

augroup ctags
    autocmd!
    autocmd BufWritePost * call s:execute_ctags()
augroup END
