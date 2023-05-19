return {
  {
    "rhysd/git-messenger.vim",
    config = function()
      vim.api.nvim_set_keymap("n", "gm", "<cmd>GitMessenger<cr>", { silent = true })
      vim.g.git_messenger_floating_win_opts = { border = "single" }
    end,
  },
}
