-- For nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.clipboard:append { "unnamedplus" }
vim.opt.hls             = true
vim.opt.number          = true
vim.opt.title           = true
vim.opt.ambiwidth       = "single"
vim.opt.expandtab       = true
vim.opt.tabstop         = 2
vim.opt.shiftwidth      = 2
vim.opt.nrformats:remove { "octal" }
vim.opt.hidden          = true
vim.opt.history         = 50
vim.opt.wrapscan        = true
vim.opt.virtualedit     = "block"
vim.opt.whichwrap       = "b,s,[,],<,>"
vim.opt.backspace       = { "indent", "eol", "start" }
vim.opt.wildmenu        = true
vim.opt.backup          = false
vim.opt.writebackup     = false
vim.opt.swapfile        = false
vim.opt.autoread        = true
vim.opt.tags            = "<tags_path>"
vim.opt.cmdheight       = 2
vim.opt.updatetime      = 300
-- shortmess may be incorrect
vim.opt.shortmess       = "c"
vim.opt.encoding        = "utf-8"
vim.opt.fileformats     = { "unix","dos","mac" }
vim.opt.fileencodings   = "utf-8"
vim.opt.termguicolors   = true
vim.opt.mouse           = ""
vim.opt.syntax          = "on"
vim.opt.filetype        = "on"
vim.cmd("filetype plugin indent on")
-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.opt.signcolumn      = "number"
-- reset augroup
vim.cmd([[
  augroup MyAutoCmd
    autocmd!
  augroup END
]])

-- perenthesis settings
vim.opt.matchpairs:append { "<:>" }
-- Disable concealing quatation
vim.g.vim_json_conceal  = 0
-- Permanently disable restore dialog
vim.g.session_autoload = "no"
-- Detect cue file
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = { "*.cue" },
  command = "set filetype=cue"
})

-- Key maps
local map = vim.api.nvim_set_keymap
map("i", "<S-Tab>", "<C-d>", { noremap = true, silent = false })
map("i", "<C-f>", "<right>", { noremap = true, silent = false })
map("i", "<C-b>", "<left>", { noremap = true, silent = false })
map("i", "<C-w>", "<Esc>vbxi", { noremap = true, silent = false })
-- Tab mappings
map("n", "<C-t>t", ":tabnew<CR>",           { noremap = true, silent = false })
map("n", "<C-l>", ":tabnext<CR>",           { noremap = true, silent = false })
map("n", "<C-h>", ":tabprev<CR>",           { noremap = true, silent = false })
map("n", "<C-t>l", ":+tabmove<CR>",         { noremap = true, silent = false })
map("n", "<C-t>h", ":-tabmove<CR>",         { noremap = true, silent = false })
map("i", "<C-t><C-t>", "<Esc>:tabnew<CR>",  { noremap = true, silent = false })
map("i", "<C-l>", "<Esc>:tabnext<CR>",      { noremap = true, silent = false })
map("i", "<C-h>", "<Esc>:tabprev<CR>",      { noremap = true, silent = false })
-- Copy filepath to clipboard
map("n", "gc", "",{
  callback = function()
    vim.fn.setreg("+", vim.fn.expand('%'))
  end,
  noremap = true,
  silent = false
})

-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Import plugins
require("lazy").setup({
  { import = "plugins" }
})

-- Set default theme
vim.cmd [[ set background=dark ]]
vim.cmd [[ colorscheme vscode ]]
vim.api.nvim_set_hl(0, "TabLine", {fg = "#999999"})

-- Define highlight group
vim.api.nvim_set_hl(0, 'LocalSearch', { bold = true, underdotted = true,})

-- Change updatetime
vim.opt.updatetime = 100
