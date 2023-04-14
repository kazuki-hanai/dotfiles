local map = vim.api.nvim_set_keymap

-- Common keymap
map("i", "<S-Tab>", "<C-d>", { noremap = true, silent = false })

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
map("n", "<space>c", "",{
  callback = function()
    vim.fn.setreg("+", vim.fn.expand('%'))
  end,
  noremap = true,
  silent = false
})
