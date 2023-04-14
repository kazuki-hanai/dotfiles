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
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require'nvim-web-devicons'.setup {
       -- globally enable different highlight colors per icon (default to true)
       -- if set to false all icons will have the default icon's color
       color_icons = true;
       -- globally enable default icons (default to false)
       -- will get overriden by `get_icons` option
       default = true;
       -- globally enable "strict" selection of icons - icon will be looked up in
       -- different tables, first by filename, and if not found by extension; this
       -- prevents cases when file doesn't have any extension but still gets some icon
       -- because its name happened to match some extension (default to false)
       strict = true;
       -- same as `override` but specifically for overrides by filename
       -- takes effect when `strict` is true
       override_by_filename = {
        [".gitignore"] = {
          icon = "",
          color = "#f1502f",
          name = "Gitignore"
        }
       };
       -- same as `override` but specifically for overrides by extension
       -- takes effect when `strict` is true
       override_by_extension = {
        ["log"] = {
          icon = "",
          color = "#81e043",
          name = "Log"
        }
       };
      }
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = {},
          lualine_b = {'diff', 'diagnostics'},
          lualine_c = {
            {
              "filename",
              path = 1,
            },
          },
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {
            {
              "filename",
              path = 1,
            }
          },
          lualine_c = {},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }
    end,
  },
  {
    "crispgm/nvim-tabline",
    config = function()
      require('tabline').setup({
        show_index = true,   -- show tab index
        show_modify = true,  -- show buffer modification indicator
        show_icon = true,    -- show file extension icon
        show_bufnr = true,   -- this appends [bufnr] to buffer section,
        modify_indicator = '[+]', -- modify indicator
        section_separators = {'', ''},
        component_separators = {'', ''},
        no_name = 'No name',      -- no name buffer name
        brackets = { '[ ', ' ]' },  -- file name brackets surrounding
      })
    end,
  },
  {
    "yggdroot/indentline",
    config = function()
      vim.g.indentLine_enabled = 1
      -- TODO: replace embeded func
      -- vim.cmd("autocmd Filetype json let g:indentLine_enabled = 0")
      -- vim.g.vim_json_syntax_conceal = 0
    end,
  },
  {
    "luochen1990/rainbow",
    config = function()
      vim.g.rainbow_active = 1
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "c", "lua", "go", "cue", "json", "terraform", "vim",
        },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        }
      }
    end,
  },
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.api.nvim_set_keymap('n', 'gb', '<cmd>Git blame<cr>', {silent = true})
    end,
  },
  {
    "airblade/vim-gitgutter",
    config = function()
      vim.opt.signcolumn              = "yes:1"
      vim.opt.numberwidth             = 3
      vim.g.gitgutter_sign_added      = "+"
      vim.g.gitgutter_sign_modified   = "~"
      vim.g.gitgutter_sign_removed    = "-"
    end,
  },
  {
    "ruifm/gitlinker.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("gitlinker").setup({
        opts = {
          action_callback = require("gitlinker.actions").copy_to_clipboard,
        }
      })
      vim.api.nvim_set_keymap('n', 'gy', '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".copy_to_clipboard})<cr>', {silent = true})
      vim.api.nvim_set_keymap('v', 'gy', '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".copy_to_clipboard})<cr>', {})
    end,
  },
  {
    "rhysd/git-messenger.vim",
    config = function()
      vim.api.nvim_set_keymap("n", "gm", "<cmd>GitMessenger<cr>", {silent = true})
      vim.g.git_messenger_floating_win_opts = { border = "single" }
    end,
  },
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = true,
    cmd = "Octo",
    config = function ()
      require"octo".setup()
    end
  },
  {
    "jiangmiao/auto-pairs",
  },
  {
    "simeji/winresizer",
    config = function()
      vim.api.nvim_set_keymap('n', '<C-w>w', '<cmd>WinResizerStartResize<cr>', {silent = true})
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "tsakirist/telescope-lazy.nvim",
    },
    config = function()
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").setup {
        defaults = {
          mappings = {
            i = {
              ["<C-f>"] = "results_scrolling_down",
              ["<C-b>"] = "results_scrolling_up",
            }
          }
        },
        pickers = {
            find_files = {
                hidden = true,
            },
        },
        extensions = {
          lazy = {
            -- Optional theme (the extension doesn't set a default theme)
            -- theme = "ivy",
            -- Whether or not to show the icon in the first column
            show_icon = true,
            -- Mappings for the actions
            mappings = {
              open_in_browser = "<C-o>",
              open_in_file_browser = "<M-b>",
              open_in_find_files = "<C-f>",
              open_in_live_grep = "<C-g>",
              open_plugins_picker = "<C-b>", -- Works only after having called first another action
              open_lazy_root_find_files = "<C-r>f",
              open_lazy_root_live_grep = "<C-r>g",
            },
          },
        },
      }

      require("telescope").load_extension("lazy")
      -- Telescope
      vim.api.nvim_set_keymap("n", "<C-s>f", "<cmd>Telescope find_files<cr>",  { noremap = true, silent = false })
      vim.api.nvim_set_keymap("n", "<C-s>g", "<cmd>Telescope live_grep<cr>",   { noremap = true, silent = false })
      vim.api.nvim_set_keymap("n", "<C-s>b", "<cmd>Telescope buffers<cr>",     { noremap = true, silent = false })
      vim.api.nvim_set_keymap("n", "<C-s>h", "<cmd>Telescope help_tags<cr>",   { noremap = true, silent = false })
      vim.api.nvim_set_keymap("n", "<C-s>k", "<cmd>Telescope keymaps<cr>",   { noremap = true, silent = false })
      vim.api.nvim_set_keymap("n", "<C-s>l", "<cmd>Telescope lazy<cr>",        { noremap = true, silent = false })
    end,
  },
  {
    "neovim/nvim-lspconfig",
  },
  {
    "hrsh7th/cmp-nvim-lsp",
  }, {
    "hrsh7th/vim-vsnip",
  }, {
    "hrsh7th/vim-vsnip-integ",
  }, {
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
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
            -- require("snippy").expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "vsnip" }, -- For vsnip users.
          -- { name = "luasnip" }, -- For luasnip users.
          -- { name = "ultisnips" }, -- For ultisnips users.
          -- { name = "snippy" }, -- For snippy users.
        }, {
          { name = "buffer" },
        })
      })
    end,
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
    config = function()
      local hop = require('hop')
      local directions = require('hop.hint').HintDirection
      hop.setup{}
      vim.keymap.set('', 'f', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
      end, {remap=true})
      vim.keymap.set('', 'F', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
      end, {remap=true})
      vim.keymap.set('', 't', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
      end, {remap=true})
      vim.keymap.set('', 'T', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
      end, {remap=true})
      vim.keymap.set('', 'gh', ":HopWord<CR>", {})
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
