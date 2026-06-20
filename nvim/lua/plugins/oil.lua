-- File explorer: edit directories as buffers
-- oil over neo-tree/nvim-tree: no sidebar, just a buffer you can edit with vim motions
-- <leader>e to open; not set as default explorer (netrw still handles gx links)
return {
  "stevearc/oil.nvim",
  dependencies = { "echasnovski/mini.icons" },
  keys = {
    { "<leader>e", "<cmd>Oil<cr>", desc = "File Explorer" },
    { "<leader>fe", "<cmd>Oil<cr>", desc = "File Explorer" },
  },
  opts = {
    default_file_explorer = false,
    -- Free C-h/C-l for vim-tmux-navigator (oil defaults them to hsplit/refresh).
    -- Open-in-split moves to C-\ to match the \ = side-by-side convention
    -- (<C-w>\, tmux \). Merged over oil's defaults (use_default_keymaps stays on).
    keymaps = {
      ["<C-h>"] = false,
      ["<C-l>"] = false,
      ["<C-\\>"] = { "actions.select", opts = { vertical = true } },
    },
  },
}
