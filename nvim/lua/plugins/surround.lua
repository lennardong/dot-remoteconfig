-- Surround: add/change/delete surrounding pairs (cs, ds, ys)
-- vim-repeat enables . to repeat surround operations
-- Shared: loaded in both VSCode and terminal (works with vscode-neovim)
return {
  { "tpope/vim-repeat", event = "VeryLazy" },
  { "tpope/vim-surround", event = "VeryLazy" },
}
