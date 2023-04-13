return {
  {
    "nvim-tree/nvim-tree.lua",
  },
  {
    "nvim-tree/nvim-web-devicons",
  },
  {
    "nvim-lualine/lualine.nvim",
  },
  {
    "crispgm/nvim-tabline",
  },
  {
    "yggdroot/indentline",
  },
  {
    "luochen1990/rainbow",
  },
  {
    "tpope/vim-fugitive",
  },
  {
    "airblade/vim-gitgutter",
  },
  {
    "ruifm/gitlinker.nvim",
  },
  {
    "jiangmiao/auto-pairs",
  },
  {
    "simeji/winresizer",
  },
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    cmd = "Telescope"
  },
  {
    "neovim/nvim-lspconfig",
  },
  {
    "hrsh7th/cmp-nvim-lsp",
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
    "hrsh7th/nvim-cmp",
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "gopls",
          "tsserver",
          "yamlls",
          "terraformls",
          "dagger",
        },
        automatic_installation = true,
      }
      -- Update registry
      local registry = require("mason-registry")
      registry.update()
    end,
  },
  -- Hop is an EasyMotion-like plugin allowing you to jump anywhere 
  -- in a document with as few keystrokes as possible.
  {
    "phaazon/hop.nvim",
  },
  -- ColorSchems
  {
    "flazz/vim-colorschemes",
  },
  {
    "Mofiqul/vscode.nvim",
  },
}
