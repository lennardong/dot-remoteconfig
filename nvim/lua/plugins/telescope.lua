-- Fuzzy finder: files, grep, buffers, LSP symbols
-- <leader>ff: git_files (falls back to find_files outside a repo)
-- <leader>fw: live grep scoped to git root
-- <leader>fp: switch project (fd sibling dirs, cd on select)
-- Uses fzf-native for faster sorting; ignores .venv, __pycache__, .parquet, etc.
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
          -- google drive temp files
          "%.tmp%.driveupload/", "%.tmp%.drivedownload/",
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
        local ok = pcall(require("telescope.builtin").git_files, { show_untracked = true })
        if not ok then
          require("telescope.builtin").find_files()
        end
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
    {
      "<leader>fc",
      function()
        require("telescope.builtin").git_commits({
          attach_mappings = function(prompt_bufnr, map)
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")
            local show_commit = function()
              local entry = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              local sha = entry.value
              vim.cmd("tabnew")
              vim.cmd("setlocal buftype=nofile bufhidden=wipe filetype=git nobuflisted")
              vim.api.nvim_buf_set_lines(0, 0, -1, false,
                vim.fn.systemlist({ "git", "show", "--stat", "-p", sha }))
              vim.cmd("0")
            end
            actions.select_default:replace(show_commit)
            map("i", "<C-o>", show_commit)
            return true
          end,
        })
      end,
      desc = "Git Commits (view)",
    },
    {
      "<leader>fC",
      function()
        require("telescope.builtin").git_bcommits({
          attach_mappings = function(prompt_bufnr, _)
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")
            actions.select_default:replace(function()
              local entry = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              local sha = entry.value
              vim.cmd("tabnew")
              vim.cmd("setlocal buftype=nofile bufhidden=wipe filetype=git nobuflisted")
              vim.api.nvim_buf_set_lines(0, 0, -1, false,
                vim.fn.systemlist({ "git", "show", "--stat", "-p", sha }))
              vim.cmd("0")
            end)
            return true
          end,
        })
      end,
      desc = "Git Buffer Commits (view)",
    },
    {
      "<leader>fs",
      function()
        local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
        local opts = vim.v.shell_error == 0 and { cwd = git_root } or {}
        require("telescope.builtin").grep_string(opts)
      end,
      desc = "Grep word under cursor",
    },
    { "<leader>cp", "<cmd>Telescope commands<cr>",               desc = "Command Palette" },
    { "gr",          "<cmd>Telescope lsp_references<cr>",         desc = "References" },
    { "<leader>ds",  "<cmd>Telescope lsp_document_symbols<cr>",   desc = "Document Symbols" },
    { "<leader>ws",  "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",  desc = "Workspace Symbols" },
  },
}
