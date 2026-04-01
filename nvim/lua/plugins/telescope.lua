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
    {
      "<leader>ff",
      function()
        require("telescope.builtin").git_files({ show_untracked = true })
      end,
      desc = "Find Files (repo)",
    },
    {
      "<leader>fw",
      function()
        local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
        if vim.v.shell_error == 0 then
          require("telescope.builtin").live_grep({ cwd = git_root })
        else
          require("telescope.builtin").live_grep()
        end
      end,
      desc = "Live Grep (repo)",
    },
    {
      "<leader>fp",
      function()
        local parent = vim.fn.fnamemodify(vim.fn.getcwd(), ":h")
        require("telescope.builtin").find_files({
          cwd = parent,
          find_command = { "fd", "--type", "d", "--max-depth", "1" },
          attach_mappings = function(_, map)
            map("i", "<CR>", function(prompt_bufnr)
              local entry = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
              require("telescope.actions").close(prompt_bufnr)
              vim.cmd.cd(parent .. "/" .. entry[1])
              vim.notify("cd → " .. entry[1])
            end)
            return true
          end,
        })
      end,
      desc = "Switch Project",
    },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",                desc = "Buffers" },
    { "<leader>cp", "<cmd>Telescope commands<cr>",               desc = "Command Palette" },
    { "gr",          "<cmd>Telescope lsp_references<cr>",         desc = "References" },
    { "<leader>ds",  "<cmd>Telescope lsp_document_symbols<cr>",   desc = "Document Symbols" },
    { "<leader>ws",  "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",  desc = "Workspace Symbols" },
  },
}
