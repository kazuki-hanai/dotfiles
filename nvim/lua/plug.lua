
-- Import plugin
local Plug = vim.fn["plug#"]
vim.call("plug#begin", vim.call("stdpath", "data") .. "/plugged")
Plug("yggdroot/indentline")
Plug("luochen1990/rainbow")
Plug("itchyny/lightline.vim")
Plug("tpope/vim-fugitive")
Plug("airblade/vim-gitgutter")
Plug("junegunn/fzf", { ["do"] = vim.fn["fzf#install()"] })
Plug("junegunn/fzf.vim")
Plug("jiangmiao/auto-pairs")
Plug("neoclide/coc.nvim", { ["branch"] = "release"})
Plug("flazz/vim-colorschemes")
Plug("simeji/winresizer")
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
fzf_func = function(opts)
  vim.fn["fzf#vim#grep"](
    "rg -u --column --line-number --hidden --ignore-case --no-heading --color=always --smart-case "..opts.args,
    1,
    opts.bang and 
      vim.fn["fzf#vim#with_preview"]({options = "--delimiter : --nth 4.."}, "up:60%") or
      vim.fn["fzf#vim#with_preview"]({options = "--delimiter : --nth 4.."}, "right:50%", "?"),
    opts.bang)
end
vim.api.nvim_create_user_command("Rg", fzf_func, { nargs = "*" })
vim.g.rg_derive_root = "true"
vim.api.nvim_set_keymap("n", "<C-s>g", ":Rg<Space>",            { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<C-s>f", ":GFiles<Space>",        { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<C-s>h", ":History<CR>",          { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<Leader>b", ":Buffers<CR>",       { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<Leader>s", ":BLines<CR>",        { noremap = true, silent = false })

-- lightline
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

-- rainbow
vim.g.rainbow_active = 1

-- vim-gitgutter
vim.opt.signcolumn              = "yes:1"
vim.opt.numberwidth             = 3
vim.g.gitgutter_sign_added      = "+"
vim.g.gitgutter_sign_modified   = "~"
vim.g.gitgutter_sign_removed    = "-"

-- winresizer
vim.g.winresizer_start_key = "<C-W>w"
