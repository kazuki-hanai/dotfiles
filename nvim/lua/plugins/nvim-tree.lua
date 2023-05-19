return {
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      vim.opt.termguicolors = true
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
      })
      vim.api.nvim_set_keymap("n", "<C-f>", ":NvimTreeFindFile<cr>", { noremap = true, silent = false })
      vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<cr>", { noremap = true, silent = false })
    end,
  },
}
