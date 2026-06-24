-- File explorer: edit directories as buffers
-- oil over neo-tree/nvim-tree: no sidebar, just a buffer you can edit with vim motions
-- <leader>e to open; not set as default explorer (netrw still handles gx links)
return {
  "stevearc/oil.nvim",
  dependencies = { "echasnovski/mini.icons" },
  keys = {
    { "<leader>e", function() require("oil").open() end, desc = "File Explorer" },
    { "<leader>fe", function() require("oil").open() end, desc = "File Explorer" },
  },
  opts = {
    default_file_explorer = false,
    -- Show dotfiles by default; g. still toggles. (.. parent row isn't a thing
    -- in oil — press - to go up.)
    view_options = { show_hidden = true },
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
