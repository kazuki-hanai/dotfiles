
-- Import plugin
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
Plug("neoclide/coc.nvim", { ["branch"] = "release"})
Plug("flazz/vim-colorschemes")
Plug("simeji/winresizer")
Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope.nvim", { tag ="0.1.1" })
Plug("neovim/nvim-lspconfig")
Plug("hrsh7th/nvim-cmp")

vim.call("plug#end")

-- NerdTree
vim.g.NERDTreeShowHidden = 1

-- indentline
vim.g.indentLine_enabled = 1
-- TODO: replace embeded func
-- vim.cmd("autocmd Filetype json let g:indentLine_enabled = 0")
-- vim.g.vim_json_syntax_conceal = 0

-- fzf
local fzf_func = function(opts)
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

-- nvim-lspconfig
local lspconfig = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  local opts = { noremap = true, silent = true }
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", opts)
end

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or 'single'
  opts.max_width= opts.max_width or math.floor(vim.fn.winwidth(0) * 0.7)
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- rust-analyzer
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  settings = {
    ['rust-analyzer'] = {}
  }
}
-- yamlls
lspconfig.yamlls.setup{
  settings = {
    yaml = {
      schemas = { kubernetes = "globPattern" },
    }
  }
}
