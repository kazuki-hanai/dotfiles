
-- Import plugin
local Plug = vim.fn["plug#"]
vim.call("plug#begin", vim.call("stdpath", "data") .. "/plugged")

Plug("nvim-tree/nvim-tree.lua")
Plug("nvim-tree/nvim-web-devicons")
Plug("nvim-lualine/lualine.nvim")
Plug("crispgm/nvim-tabline")
Plug("yggdroot/indentline")
Plug("luochen1990/rainbow")
Plug("tpope/vim-fugitive")
Plug("airblade/vim-gitgutter")
Plug("jiangmiao/auto-pairs")
Plug("simeji/winresizer")
Plug("nvim-lua/plenary.nvim") --
Plug("nvim-telescope/telescope.nvim")
Plug("neovim/nvim-lspconfig")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/cmp-cmdline")
Plug("hrsh7th/nvim-cmp")
Plug("williamboman/mason.nvim", { ["do"] = vim.fn[":MasonUpdate"] })
Plug("williamboman/mason-lspconfig.nvim")

-- Hop is an EasyMotion-like plugin allowing you to jump anywhere 
-- in a document with as few keystrokes as possible.
Plug("phaazon/hop.nvim")

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

-- tabline
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

-- indentline
vim.g.indentLine_enabled = 1
-- TODO: replace embeded func
-- vim.cmd("autocmd Filetype json let g:indentLine_enabled = 0")
-- vim.g.vim_json_syntax_conceal = 0

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
    lualine_a = {},
    lualine_b = {'diff', 'diagnostics'},
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

-- telescope
require("telescope").setup {
  defaults = {
  },
  pickers = {
      find_files = {
          hidden = true,
      },
  },
}

-- nvim-lspconfig
require("plugins/nvim-lspconfig")

-- nvim-cmp
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

-- hop.nvim
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

