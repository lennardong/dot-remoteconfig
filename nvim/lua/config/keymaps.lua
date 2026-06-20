-- Keymaps — shared across VSCode and terminal

-- Equalize splits
vim.keymap.set("n", "<C-w>e", "<C-w>=", { desc = "Equalize splits" })

-- Splits — symmetric with tmux prefix \/-
vim.keymap.set("n", "<C-w>\\", "<cmd>vsplit<cr>", { desc = "Vertical split" })
vim.keymap.set("n", "<C-w>-", "<cmd>split<cr>", { desc = "Horizontal split" })

-- Split navigation — terminal only (VSCode owns its own). Native nvim window nav,
-- no tmux crossover: at an edge it stays put. tmux panes use prefix-q numbers.
if not vim.g.vscode then
  vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left split" })
  vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower split" })
  vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper split" })
  vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right split" })
end

-- Worktree workspace — open current repo as one session, one window per worktree
vim.keymap.set("n", "<C-f>", "<cmd>silent !~/.config-remote/tmux/tmux-worktree<CR>")

-- Theme toggle dark/light
vim.keymap.set("n", "<leader>tt", function()
  local current = vim.g.colors_name
  if current == "dracula" then
    vim.cmd("colorscheme github_light")
  else
    vim.cmd("colorscheme dracula")
  end
  if _G.apply_cursor then _G.apply_cursor() end
end, { desc = "Toggle dark/light theme" })

-- Yank selection with file path + line numbers (for pasting into Claude Code)
vim.keymap.set("v", "<leader>yp", function()
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  if start_line > end_line then start_line, end_line = end_line, start_line end
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  local path = vim.fn.expand("%:.")  -- relative path
  local header = path .. ":" .. start_line .. "-" .. end_line
  local text = header .. "\n" .. table.concat(lines, "\n")
  vim.fn.setreg("+", text)
  vim.notify("Yanked with path: " .. header)
end, { desc = "Yank selection with file path" })
