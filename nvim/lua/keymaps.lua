local map = vim.api.nvim_set_keymap

-- Common keymap
map("i", "<S-Tab>", "<C-d>", { noremap = true, silent = false })

-- Tab mappings
map("n", "<C-t>", ":tabnew<CR>",        { noremap = true, silent = false })
map("n", "<C-l>", ":tabnext<CR>",       { noremap = true, silent = false })
map("n", "<C-h>", ":tabprev<CR>",       { noremap = true, silent = false })
map("n", "tl",    ":+tabmove<CR>",      { noremap = true, silent = false })
map("n", "th",    ":-tabmove<CR>",      { noremap = true, silent = false })
map("i", "<C-t>", "<Esc>:tabnew<CR>",   { noremap = true, silent = false })
map("i", "<C-l>", "<Esc>:tabnext<CR>",  { noremap = true, silent = false })
map("i", "<C-h>", "<Esc>:tabprev<CR>",  { noremap = true, silent = false })
map("n", "<C-h>", "<Esc>:tabprev<CR>",  { noremap = true, silent = false })

-- NerdTree
map("n", "<leader>n", ":NERDTreeFind<cr>",   { noremap = true, silent = false })
map("n", "<cs-n>",    ":NERDTreeToggle<cr>", { noremap = true, silent = false })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>",  { noremap = true, silent = false })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>",   { noremap = true, silent = false })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>",     { noremap = true, silent = false })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>",   { noremap = true, silent = false })

-- fzf
map("n", "<C-s>g", ":Rg<Space>",       { noremap = true, silent = false })
map("n", "<C-s>f", ":GFiles<Space>",   { noremap = true, silent = false })
map("n", "<C-s>h", ":History<CR>",     { noremap = true, silent = false })
map("n", "<Leader>b", ":Buffers<CR>",  { noremap = true, silent = false })
map("n", "<Leader>s", ":BLines<CR>",   { noremap = true, silent = false })
