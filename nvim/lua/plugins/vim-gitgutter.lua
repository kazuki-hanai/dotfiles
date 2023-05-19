return {
  {
    "airblade/vim-gitgutter",
    config = function()
      vim.opt.signcolumn            = "yes:1"
      vim.opt.numberwidth           = 3
      vim.g.gitgutter_sign_added    = "+"
      vim.g.gitgutter_sign_modified = "~"
      vim.g.gitgutter_sign_removed  = "-"
    end,
  },
}
