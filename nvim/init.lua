-- Neovim config — VSCode integration + terminal IDE
-- Works on macOS (native clipboard) and remote/SSH (OSC 52 passthrough)

-- OSC 52 clipboard over SSH — yanks propagate to local macOS clipboard
-- Gated: macOS uses native clipboard; SSH/tmux uses explicit OSC 52 provider
if vim.env.SSH_TTY then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end

require("config.options")
require("config.keymaps")

if vim.g.vscode then
  require("config.vscode")
end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Shared: load in both VSCode and terminal
  { import = "plugins.sneak" },
  { import = "plugins.surround" },

  -- Terminal-only: gated so VSCode mode loads nothing extra
  not vim.g.vscode and { import = "plugins.theme" }      or nil,
  not vim.g.vscode and { import = "plugins.telescope" }   or nil,
  not vim.g.vscode and { import = "plugins.lsp" }         or nil,
  not vim.g.vscode and { import = "plugins.treesitter" }  or nil,
  not vim.g.vscode and { import = "plugins.blink" }       or nil,
  not vim.g.vscode and { import = "plugins.conform" }     or nil,
  not vim.g.vscode and { import = "plugins.oil" }         or nil,
  not vim.g.vscode and { import = "plugins.whichkey" }    or nil,
  not vim.g.vscode and { import = "plugins.render-markdown" } or nil,
})
