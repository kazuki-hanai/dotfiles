return {
  -- crate management
  {
    "saecki/crates.nvim",
    opts = {
    },
    -- stylua: ignore
    keys = {
      { "<leader>ct", function() require("crates").toggle() end,                  desc = "toggle" },
      { "<leader>cr", function() require("crates").reload() end,                  desc = "reload" },
      { "<leader>cv", function() require("crates").show_versions_popup() end,     desc = "show_versions_popup" },
      { "<leader>cf", function() require("crates").show_features_popup() end,     desc = "show_features_popup" },
      { "<leader>cd", function() require("crates").show_dependencies_popup() end, desc = "show_dependencies_popup" },
      { "<leader>cu", function() require("crates").update_crate() end,            desc = "update_crate" },
      { "<leader>cu", function() require("crates").update_crates() end,           desc = "update_crates" },
      { "<leader>ca", function() require("crates").update_all_crates() end,       desc = "update_all_crates" },
      { "<leader>cU", function() require("crates").upgrade_crate() end,           desc = "upgrade_crate" },
      { "<leader>cA", function() require("crates").upgrade_all_crates() end,      desc = "upgrade_all_crates" },
      { "<leader>cH", function() require("crates").open_homepage() end,           desc = "open_homepage" },
      { "<leader>cR", function() require("crates").open_repository() end,         desc = "open_repository" },
      { "<leader>cD", function() require("crates").open_documentation() end,      desc = "open_documentation" },
      { "<leader>cC", function() require("crates").open_crates_io() end,          desc = "open_crates_io" },
      -- {'v', '<leader>cU', crates.upgrade_crates, opts)
    },
  },
}
