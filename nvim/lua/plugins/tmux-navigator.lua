-- Transparent navigation between nvim splits and tmux panes.
-- C-h/j/k/l crosses the nvim/tmux boundary with no prefix; degrades to
-- nvim-only split nav when outside tmux. tmux side: is_vim check in tmux.conf.
return {
  "christoomey/vim-tmux-navigator",
  -- Stop at edge splits instead of wrapping to the opposite side.
  init = function()
    vim.g.tmux_navigator_no_wrap = 1
  end,
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
