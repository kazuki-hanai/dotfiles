return {
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
      vim.api.nvim_set_keymap('n', 'gy',
        '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".copy_to_clipboard})<cr>',
        { silent = true })
      vim.api.nvim_set_keymap('v', 'gy',
        '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".copy_to_clipboard})<cr>',
        {})
    end,
  },
}
