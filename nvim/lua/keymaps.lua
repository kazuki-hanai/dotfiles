local map = vim.api.nvim_set_keymap

-- Common keymap
map("i", "<S-Tab>", "<C-d>", { noremap = true, silent = false })

-- Tab mappings
map("n", "<C-t>t", ":tabnew<CR>",        { noremap = true, silent = false })
map("n", "<C-l>", ":tabnext<CR>",       { noremap = true, silent = false })
map("n", "<C-h>", ":tabprev<CR>",       { noremap = true, silent = false })
map("n", "<C-t>l", ":+tabmove<CR>",      { noremap = true, silent = false })
map("n", "<C-t>h", ":-tabmove<CR>",      { noremap = true, silent = false })
map("i", "<C-t><C-t>", "<Esc>:tabnew<CR>",   { noremap = true, silent = false })
map("i", "<C-l>", "<Esc>:tabnext<CR>",  { noremap = true, silent = false })
map("i", "<C-h>", "<Esc>:tabprev<CR>",  { noremap = true, silent = false })

-- nvim-tree
map("n", "<C-b>f", ":NvimTreeFindFile<cr>",   { noremap = true, silent = false })
map("n", "<C-b>n", ":NvimTreeToggle<cr>", { noremap = true, silent = false })

-- Telescope
map("n", "<C-s>f", "<cmd>Telescope find_files<cr>",  { noremap = true, silent = false })
map("n", "<C-s>g", "<cmd>Telescope live_grep<cr>",   { noremap = true, silent = false })
map("n", "<C-s>b", "<cmd>Telescope buffers<cr>",     { noremap = true, silent = false })
map("n", "<C-s>h", "<cmd>Telescope help_tags<cr>",   { noremap = true, silent = false })
