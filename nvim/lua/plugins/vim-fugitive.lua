return {
  {
    "tpope/vim-fugitive",
    dependencies = {
      "MunifTanjim/nui.nvim"
    },
    config = function()
      vim.api.nvim_set_keymap("n", "gb", "<cmd>Git blame<cr>", { silent = true })
    end,
  },
}
