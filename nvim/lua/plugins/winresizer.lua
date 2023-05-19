return {
  {
    "simeji/winresizer",
    init = function()
      vim.g.winresizer_start_key = '<C-w>w'
      vim.g.winresizer_gui_start_key = '<C-w>w'
    end,
    config = function()
      vim.api.nvim_set_keymap('n', '<C-w>w', '<cmd>WinResizerStartResize<cr>', { silent = true })
    end,
  },
}
