return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        path_display = { "truncate" },
        file_ignore_patterns = {
          -- dependency / env dirs
          "%.venv/", "%.git/", "node_modules/",
          -- build / cache dirs
          "__pycache__/", "%.pytest_cache/", "%.ruff_cache/", "dist/",
          -- generated / binary files
          "%.parquet", "%.pyc", "%.pyo",
          -- lock and system files
          "uv%.lock", "%.DS_Store",
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
        },
      },
    })
    telescope.load_extension("fzf")
  end,
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>",             desc = "Find Files" },
    { "<leader>fw", "<cmd>Telescope live_grep<cr>",              desc = "Live Grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",                desc = "Buffers" },
    { "<leader>cp", "<cmd>Telescope commands<cr>",               desc = "Command Palette" },
    { "gr",          "<cmd>Telescope lsp_references<cr>",         desc = "References" },
    { "<leader>ds",  "<cmd>Telescope lsp_document_symbols<cr>",   desc = "Document Symbols" },
    { "<leader>ws",  "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",  desc = "Workspace Symbols" },
  },
}
