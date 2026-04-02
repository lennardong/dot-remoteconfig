-- Keymaps — shared across VSCode and terminal

-- Equalize splits
vim.keymap.set("n", "<C-w>e", "<C-w>=", { desc = "Equalize splits" })

-- Splits — symmetric with tmux prefix \/-
vim.keymap.set("n", "<C-w>\\", "<cmd>vsplit<cr>", { desc = "Vertical split" })
vim.keymap.set("n", "<C-w>-", "<cmd>split<cr>", { desc = "Horizontal split" })

-- Sessionizer — switch tmux session to another repo
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.config-remote/tmux/tmux-sessionizer<CR>")
