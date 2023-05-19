return {
  {
    "windwp/nvim-autopairs",
    config = function ()
      require("nvim-autopairs").setup{}
    end
  },
  {
    "neovim/nvim-lspconfig",
  },
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "hrsh7th/vim-vsnip",
  },
  {
    "hrsh7th/vim-vsnip-integ",
  },
  {
    "hrsh7th/cmp-buffer",
  },
  {
    "hrsh7th/cmp-path",
  },
  {
    "hrsh7th/cmp-cmdline",
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  -- ColorSchems
  {
    "flazz/vim-colorschemes",
  },
  {
    "Mofiqul/vscode.nvim",
  },
}
