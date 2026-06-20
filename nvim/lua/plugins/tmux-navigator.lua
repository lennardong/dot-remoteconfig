-- Transparent navigation between nvim splits and tmux panes.
-- C-h/j/k/l crosses the nvim/tmux boundary with no prefix; degrades to
-- nvim-only split nav when outside tmux. tmux side: is_vim check in tmux.conf.
return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft", "TmuxNavigateDown",
    "TmuxNavigateUp", "TmuxNavigateRight",
  },
  keys = {
    { "<C-h>", "<cmd>TmuxNavigateLeft<cr>" },
    { "<C-j>", "<cmd>TmuxNavigateDown<cr>" },
    { "<C-k>", "<cmd>TmuxNavigateUp<cr>" },
    { "<C-l>", "<cmd>TmuxNavigateRight<cr>" },
  },
}
