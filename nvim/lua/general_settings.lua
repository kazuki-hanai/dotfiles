vim.opt.clipboard:append { "unnamedplus" }
vim.opt.hls             = true
vim.opt.number          = true
vim.opt.title           = true
vim.opt.ambiwidth       = "double"
vim.opt.expandtab       = true
vim.opt.tabstop         = 8
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
vim.opt.ambiwidth       = "double"
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
