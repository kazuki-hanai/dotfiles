
local Plug = vim.fn["plug#"]
vim.call("plug#begin", vim.call("stdpath", "data") .. "/plugged")

Plug("scrooloose/nerdtree")
Plug("yggdroot/indentline")
Plug("luochen1990/rainbow")
Plug("itchyny/lightline.vim")
Plug("tpope/vim-fugitive")
Plug("airblade/vim-gitgutter")
Plug("junegunn/fzf", { ["do"] = vim.fn["fzf#install()"] })
Plug("junegunn/fzf.vim")
Plug("jiangmiao/auto-pairs")
Plug("jiangmiao/auto-pairs")
Plug("neoclide/coc.nvim", { ["branch"] = "release"})
Plug("flazz/vim-colorschemes")
Plug("simeji/winresizer")
Plug("xolox/vim-misc")
Plug("xolox/vim-session")
Plug("xolox/vim-session")

vim.call("plug#end")

-- NerdTree
vim.api.nvim_set_keymap("n", "<leader>n",     ":NERDTreeFind<CR>",    { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<C-n>",         ":NERDTreeToggle<CR>",  { noremap = true, silent = false })
vim.g.NERDTreeShowHidden = 1

-- indentline
vim.g.indentLine_enabled = 1
-- TODO: replace embeded func
vim.cmd("autocmd Filetype json let g:indentLine_enabled = 0")
vim.g.vim_json_syntax_conceal = 0

-- fzf
-- " {{{ fzf
-- command! -bang -nargs=* Rg
--     \ call fzf#vim#grep(
--     \ "rg -u --column --line-number --hidden --ignore-case --no-heading --color=always --smart-case ". <q-args>, 1,
--     \ <bang>0 ? fzf#vim#with_preview({"options": "--delimiter : --nth 4.."}, "up:60%")
--     \ : fzf#vim#with_preview({"options": "--delimiter : --nth 4.."}, "right:50%", "?"),
--     \ <bang>0)
-- let g:rg_derive_root="true"
-- nnoremap <C-s> :Rg<Space>
-- nnoremap <C-p> :GFiles<CR>
-- " nnoremap <C-h> :History<CR>
-- nnoremap <Leader>b :Buffers<cr>
-- nnoremap <Leader>s :BLines<cr>
-- " }}} fzf

-- lightline
-- " {{{ lightline
-- function! LightlineFilename()
--   " If winwidth is small, return only filename not 
--   " included whole path.
--   if winwidth(0) < 80
--     return expand("%:t")
--   else
--     let root = fnamemodify(get(b:, "git_dir"), ":h")
--     let path = expand("%:p")
--     if path[:len(root)-1] ==# root
--       return path[len(root)+1:]
--     endif
--     return expand("%")
--   endif
-- endfunction
-- 
-- function! GitStatus()
--   " If winwidth is small, this function doesn"t return
--   " any string
--   if winwidth(0) < 80
--     return printf("%s", FugitiveHead())
--   else
--     let [a,m,r] = GitGutterGetHunkSummary()
--     return printf("%s +%d ~%d -%d", FugitiveHead(), a, m, r)
--   endif
-- endfunction
-- 
-- function! ModeMap()
--   if winwidth(0) < 80
--     let mode_map = {
--     \ "n" : "N",
--     \ "i" : "I",
--     \ "R" : "R",
--     \ "v" : "V",
--     \ "V" : "VL",
--     \ "\<C-v>": "VB",
--     \ "c" : "C",
--     \ "s" : "S",
--     \ "S" : "SL",
--     \ "\<C-s>": "SB",
--     \ "t": "T",
--     \ }
--   else
--     let mode_map = {
--     \ "n" : "NORMAL",
--     \ "i" : "INSERT",
--     \ "R" : "REPLACE",
--     \ "v" : "VISUAL",
--     \ "V" : "V-LINE",
--     \ "\<C-v>": "V-BLOCK",
--     \ "c" : "COMMAND",
--     \ "s" : "SELECT",
--     \ "S" : "S-LINE",
--     \ "\<C-s>": "S-BLOCK",
--     \ "t": "TERMINAL",
--     \ }
--   endif
--   return mode_map
-- endfunction
-- 
-- let g:lightline = {
-- \   "mode_map": ModeMap(),
-- \   "active": {
-- \     "left":[ [ "mode", "paste" ],
-- \              [ "gitbranch", "readonly", "filename", "modified" ]
-- \     ]
-- \   },
-- \   "component": {
-- \     "lineinfo": " %3l:%-2v",
-- \   },
-- \   "component_function": {
-- \     "gitbranch": "GitStatus",
-- \     "filename": "LightlineFilename",
-- \   },
-- \ }
-- " }}} lightline

-- rainbow
vim.g.rainbow_active = 1

-- vim-gitgutter
vim.opt.signcolumn              = "yes:1"
vim.opt.numberwidth             = 3
vim.g.gitgutter_sign_added      = "+"
vim.g.gitgutter_sign_modified   = "~"
vim.g.gitgutter_sign_removed    = "-"

-- winresizer
vim.g.winresizer_start_key = "<C-Q>"
