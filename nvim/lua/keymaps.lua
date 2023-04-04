
-- " common keymap
vim.api.nvim_set_keymap("i", "<S-Tab>", "<C-d>",                { noremap = true, silent = false })

-- " Tab mappings
vim.api.nvim_set_keymap("n", "<C-t>",   ":tabnew<CR>",          { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<C-l>",   ":tabnext<CR>",         { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<C-h>",   ":tabprev<CR>",         { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "tl",      ":+tabmove<CR>",        { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "th",      ":-tabmove<CR>",        { noremap = true, silent = false })
vim.api.nvim_set_keymap("i", "<C-t>",   "<Esc>:tabnew<CR>",     { noremap = true, silent = false })
vim.api.nvim_set_keymap("i", "<C-l>",   "<Esc>:tabnext<CR>",    { noremap = true, silent = false })
vim.api.nvim_set_keymap("i", "<C-h>",   "<Esc>:tabprev<CR>",    { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<C-h>",   "<Esc>:tabprev<CR>",    { noremap = true, silent = false })
