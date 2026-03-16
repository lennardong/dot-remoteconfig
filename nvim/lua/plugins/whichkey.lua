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
    },
  },
}
