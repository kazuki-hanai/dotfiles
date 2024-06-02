return {
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
          "markdownlint",
        },
        automatic_installation = true,
      }
      -- Update registry
      local registry = require("mason-registry")
      registry.update()
    end,
  },
}
