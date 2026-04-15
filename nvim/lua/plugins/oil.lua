-- File explorer: edit directories as buffers
-- oil over neo-tree/nvim-tree: no sidebar, just a buffer you can edit with vim motions
-- <leader>e to open; not set as default explorer (netrw still handles gx links)
return {
  "stevearc/oil.nvim",
  keys = {
    { "<leader>e", "<cmd>Oil<cr>", desc = "File Explorer" },
  },
  opts = {
    default_file_explorer = false,
  },
}
