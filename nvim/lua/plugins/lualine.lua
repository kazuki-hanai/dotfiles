return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local function charscount()
        local mode = vim.fn.mode(true)
        local line_start = vim.fn.line('v')
        local line_end = vim.fn.line('.')
        local line_num = tostring(math.abs(line_start - line_end) + 1)
        local chars_num = tostring(vim.fn.wordcount()['visual_chars'])
        if mode:match('[vV]') then
          return line_num .. ':' .. chars_num
        else
          return ''
        end
      end

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
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
          lualine_b = { 'diff', 'diagnostics' },
          lualine_c = {
            {
              "filename",
              path = 1,
            },
          },
          lualine_x = { charscount, 'encoding', 'fileformat', 'filetype', 'location', 'progress' },
          lualine_y = {},
          lualine_z = {}
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
          lualine_x = { 'location' },
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
}
