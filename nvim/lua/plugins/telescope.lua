return {
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = true,
    cmd = "Octo",
    config = function()
      require "octo".setup()
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "tsakirist/telescope-lazy.nvim",
    },
    config = function()
      require("telescope").setup {
        defaults = {
          mappings = {
            i = {
              ["<C-f>"] = "results_scrolling_down",
              ["<C-b>"] = "results_scrolling_up",
            }
          },
          file_sorter = require("telescope.sorters").get_fuzzy_file,
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
    end,
    keys = {
      { "<C-s>f", function() require("telescope.builtin").find_files() end, mode = "n", desc = "Telescope find_files" },
      { "<C-s>g", function() require("telescope.builtin").live_grep() end,  mode = "n", desc = "Telescope live_grep" },
      { "<C-s>b", function() require("telescope.builtin").buffers() end,    mode = "n", desc = "Telescope buffers" },
      { "<C-s>h", function() require("telescope.builtin").help_tags() end,  mode = "n", desc = "Telescope buffers" },
      { "<C-s>k", function() require("telescope.builtin").keymaps() end,    mode = "n", desc = "Telescope buffers" },
      { "<C-s>l", function() require("telescope.builtin").lazy() end,       mode = "n", desc = "Telescope buffers" },
      {
        "<C-s>s",
        function()
          require("telescope.builtin").lsp_document_symbols({
            show_line = true,
          })
        end,
        mode = "n",
        desc = "Telescope buffers"
      },
      {
        "<C-s>S",
        function()
          require("telescope.builtin").lsp_workspace_symbols({
            show_line = true,
          })
        end,
        mode = "n",
        desc = "Telescope buffers"
      },
    }
  },
}
