-- Keymaps — shared across VSCode and terminal

-- Equalize splits
vim.keymap.set("n", "<C-w>e", "<C-w>=", { desc = "Equalize splits" })

-- Splits — symmetric with tmux prefix \/-
vim.keymap.set("n", "<C-w>\\", "<cmd>vsplit<cr>", { desc = "Vertical split" })
vim.keymap.set("n", "<C-w>-", "<cmd>split<cr>", { desc = "Horizontal split" })

-- Sessionizer — switch tmux session to another repo
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.config-remote/tmux/tmux-sessionizer<CR>")

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
