-- Keymaps — shared across VSCode and terminal

-- Center the cursor after search-repeat (zz), unfold if needed (zv)
vim.keymap.set("n", "n", "nzzzv", { desc = "Search next (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Search prev (centered)" })

-- Equalize splits
vim.keymap.set("n", "<C-w>e", "<C-w>=", { desc = "Equalize splits" })

-- Splits — symmetric with tmux prefix \/-
vim.keymap.set("n", "<C-w>\\", "<cmd>vsplit<cr>", { desc = "Vertical split" })
vim.keymap.set("n", "<C-w>-",  "<cmd>split<cr>",  { desc = "Horizontal split" })
vim.keymap.set("n", "<C-w>x",  "<C-w>c",          { desc = "Close split" })

-- C-h/j/k/l split+pane navigation: owned by vim-tmux-navigator (plugins/tmux-navigator.lua),
-- which crosses the nvim/tmux boundary. tmux side: is_vim check in tmux.conf.

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
local function yank_with_path(start_line, end_line)
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  local path = vim.fn.expand("%:.")
  local header = path .. ":" .. start_line .. "-" .. end_line
  vim.fn.setreg("+", header .. "\n" .. table.concat(lines, "\n"))
  vim.notify("Yanked with path: " .. header)
end

vim.keymap.set("v", "<leader>yp", function()
  local s = vim.fn.line("v")
  local e = vim.fn.line(".")
  if s > e then s, e = e, s end
  yank_with_path(s, e)
end, { desc = "Yank selection with file path" })

-- :12,25YP — range form for use without visual selection
vim.api.nvim_create_user_command("YP", function(opts)
  yank_with_path(opts.line1, opts.line2)
end, { range = true, desc = "Yank range with file path" })
