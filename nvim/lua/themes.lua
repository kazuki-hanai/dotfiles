-- vim.cmd('colorscheme iceberg') 
vim.cmd [[ set background=dark ]]
vim.cmd [[ colorscheme vscode ]]
vim.api.nvim_set_hl(0, "TabLine", {fg = "#999999"})

-- tabline
require("tabline").setup({
  show_index = false,   -- show tab index
  show_modify = true,  -- show buffer modification indicator
  show_icon = true,    -- show file extension icon
  show_bufnr = true,   -- this appends [bufnr] to buffer section,
  modify_indicator = '[+]', -- modify indicator
  no_name = 'No name',      -- no name buffer name
  brackets = { '[ ', ' ]' },  -- file name brackets surrounding
})
