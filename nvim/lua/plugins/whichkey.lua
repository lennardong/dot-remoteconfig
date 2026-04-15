-- Which-key: popup showing available keybinds after pressing <leader>
-- Groups defined here; individual bindings registered by each plugin
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>r", group = "refactor" },
      { "<leader>d", group = "document" },
      { "<leader>f", group = "find" },
      { "<leader>v", group = "view" },
      { "<leader>w", group = "workspace" },
      { "<leader>y", group = "yank" },
    },
  },
}
