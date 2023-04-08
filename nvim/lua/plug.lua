
-- Import plugin
local Plug = vim.fn["plug#"]
vim.call("plug#begin", vim.call("stdpath", "data") .. "/plugged")

Plug("nvim-tree/nvim-tree.lua")
Plug("nvim-tree/nvim-web-devicons")
Plug("yggdroot/indentline")
Plug("luochen1990/rainbow")
Plug("nvim-lualine/lualine.nvim")
Plug("tpope/vim-fugitive")
Plug("airblade/vim-gitgutter")
Plug("junegunn/fzf", { ["do"] = vim.fn["fzf#install()"] })
Plug("junegunn/fzf.vim")
Plug("jiangmiao/auto-pairs")
Plug("simeji/winresizer")
Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope.nvim", { tag ="0.1.1" })
Plug("neovim/nvim-lspconfig")
Plug("williamboman/mason.nvim", { ["do"] = vim.fn[":MasonUpdate"] })
Plug("williamboman/mason-lspconfig.nvim")

-- ColorSchems
Plug("flazz/vim-colorschemes")
Plug("Mofiqul/vscode.nvim")

vim.call("plug#end")

-- nvim-tree
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

-- nvim-web-devicons
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

-- indentline
vim.g.indentLine_enabled = 1
-- TODO: replace embeded func
-- vim.cmd("autocmd Filetype json let g:indentLine_enabled = 0")
-- vim.g.vim_json_syntax_conceal = 0

-- fzf
local fzf_func = function(opts)
  vim.fn["fzf#vim#grep"](
    "rg -u --column --line-number --hidden --ignore-case --no-heading --color=always --smart-case "..opts.args,
    1,
    opts.bang and
      vim.fn["fzf#vim#with_preview"]({options = "--delimiter : --nth 4.."}, "up:60%") or
      vim.fn["fzf#vim#with_preview"]({options = "--delimiter : --nth 4.."}, "right:50%", "?"),
    opts.bang)
end
vim.api.nvim_create_user_command("Rg", fzf_func, { nargs = "*" })
vim.g.rg_derive_root = "true"

-- lightline
local unpack = unpack or table.unpack
table.slice = function(a, start ,_end)
    return {unpack(a, start, _end)}
end

-- lualine.nvim
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
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {
      {
        "filename",
        path = 1,
      }
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        "filename",
        path = 1,
      }
    },
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

-- rainbow
vim.g.rainbow_active = 1

-- vim-gitgutter
vim.opt.signcolumn              = "yes:1"
vim.opt.numberwidth             = 3
vim.g.gitgutter_sign_added      = "+"
vim.g.gitgutter_sign_modified   = "~"
vim.g.gitgutter_sign_removed    = "-"

-- winresizer
vim.g.winresizer_start_key = "<C-W>w"

-- mason
require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {
    "lua_ls",
    "rust_analyzer",
    "gopls",
    "tsserver",
    "yamlls",
  }
}

-- nvim-lspconfig
require("plugins/nvim-lspconfig")
