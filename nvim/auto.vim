" "inoremap { {}<LEFT>
" "inoremap [ []<LEFT>
" "inoremap ( ()<LEFT>
" "inoremap {<Enter> {}<Left><CR><ESC><S-o>
" "inoremap [<Enter> []<Left><CR><ESC><S-o>
" "inoremap (<Enter> ()<Left><CR><ESC><S-o>
" "
" "" auto complete
" "function! s:skipClosePare(defkey,altkey)
" "  if getline('.')[col('.') - 1] == a:defkey
" "    return a:altkey
" "  endif
" "  return a:defkey
" "endfunction
" "inoremap <buffer> <expr> ) <SID>skipClosePare(")", "\<Right>")
" "inoremap <buffer> <expr> } <SID>skipClosePare("}", "\<Right>")
" "inoremap <buffer> <expr> ] <SID>skipClosePare("]", "\<Right>")
" "
" "if &ft!='vim'
" "  inoremap ' ''<LEFT>
" "  inoremap " ""<LEFT>
" "endif
" "
