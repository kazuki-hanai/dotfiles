return {
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {}
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
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
  {
    "L3MON4D3/LuaSnip",
    version = "1.*",
    build = "make install_jsregexp"
  },
  -- {
  --   "glepnir/lspsaga.nvim",
  --   event = "LspAttach",
  --   version = "v0.2.9",
  --   config = function()
  --     require("lspsaga").setup({})
  --   end,
  --   dependencies = { { "nvim-tree/nvim-web-devicons" } },
  --   keys = {
  --     -- { "gh",         "<cmd>Lspsaga lsp_finder<CR>" },
  --     { "<leader>ca", { "<cmd>Lspsaga code_action<CR>", mode = { "n", "v" } } },
  --     { "gr",         "<cmd>Lspsaga rename<CR>" },
  --     { "gr",         "<cmd>Lspsaga rename ++project<CR>" },
  --     { "gp",         "<cmd>Lspsaga peek_definition<CR>" },
  --     { "gd",         "<cmd>Lspsaga goto_definition<CR>" },
  --     { "gt",         "<cmd>Lspsaga peek_type_definition<CR>" },
  --     { "gt",         "<cmd>Lspsaga goto_type_definition<CR>" },
  --     { "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>" },
  --     { "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>" },
  --     { "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>" },
  --     { "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>" },
  --     { "[e",         "<cmd>Lspsaga diagnostic_jump_prev<CR>" },
  --     { "]e",         "<cmd>Lspsaga diagnostic_jump_next<CR>" },
  --     { "[E", function()
  --       require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
  --     end },
  --     { "]E", function()
  --       require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
  --     end },
  --     { "<leader>o", "<cmd>Lspsaga outline<CR>" },
  --     { "K",         "<cmd>Lspsaga hover_doc<CR>" },
  --     { "K",         "<cmd>Lspsaga hover_doc ++keep<CR>" },
  --     -- { "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>" },
  --     -- { "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>" },
  --     -- { "<A-d>",      { "<cmd>Lspsaga term_toggle<CR>", mode = { "n", "t" } } },
  --   },
  -- },
  {
    "github/copilot.vim",
    config = function()
      vim.g.copilot_filetypes = {
        bash = true,
        javascript = true,
        typescript = true,
        yaml = true,
        json = true,
        go = true,
        rust = true,
        python = true,
        lua = true,
        markdown = true,
        html = true,
        css = true,
      }
      vim.keymap.set('i', '<C-c>p', '<Plug>(copilot-previous)')
      vim.keymap.set('i', '<C-c>n', '<Plug>(copilot-next)')
      vim.keymap.set('i', '<C-c>w', '<Plug>(copilot-accept-word)')
      vim.keymap.set('i', '<C-c>l', '<Plug>(copilot-accept-line)')
    end,
  },
  {
    "uga-rosa/utf8.nvim"
  },
  {
    'tzachar/local-highlight.nvim', 
    config = function()

      require('local-highlight').setup({
        -- file_types = {'lua'},
        hlgroup = 'LocalSearch',
      })

      -- Attach to all buffers
      vim.api.nvim_create_autocmd('BufRead', {
        pattern = {'*.*'},
        callback = function(data)
          require('local-highlight').attach(data.buf)
        end
      })
    end
  },
  {
    'kessejones/term.nvim',
    config = function()
      require("term").setup({
        shell = vim.o.shell,
        width = 0.9,
        height = 0.7,
        anchor = "NW",
        position = "center",
        title = {
          align = "center",
        },
        border = {
          chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          hl = "TermBorder",
        },
      })

      -- vim.keymap.set({ 't' }, '<C-\\><C-t>', require('term').new, { silent = true })
      vim.keymap.set({ 'n', 't' }, '<C-\\><C-\\>', require('term').toggle, { silent = true })
      -- vim.keymap.set({ 't' }, '<C-\\><C-n>', require('term').next, { silent = true })
      -- vim.keymap.set({ 't' }, '<C-\\><C-p>', require('term').prev, { silent = true })
    end
  },
  {
    'mbbill/undotree',
    config = function ()
      vim.keymap.set({ 'n' }, '<leader>u', ':UndotreeToggle<CR>', { noremap = true, silent = true })
    end
  },
}
