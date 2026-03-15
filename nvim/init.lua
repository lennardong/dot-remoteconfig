-- Minimal WSL neovim config for vscode-neovim
-- Full config lives on Mac; this ensures CR works in VS Code over WSL

-- OSC 52 clipboard over SSH — yanks propagate to local macOS clipboard
-- Explicit provider so it works even when auto-detection fails (tmux, mosh, etc.)
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
vim.o.clipboard = "unnamedplus"

if vim.g.vscode then
  -- Ensure no plugin hijacks <CR> in insert mode
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      vim.schedule(function()
        vim.keymap.set("i", "<CR>", "<CR>", { noremap = true })
      end)
    end,
  })

  -- Disable neovim's indent engine so it doesn't fight VS Code's
  vim.api.nvim_create_autocmd("FileType", {
    callback = function()
      vim.bo.indentexpr = ""
      vim.bo.indentkeys = ""
      vim.bo.smartindent = false
      vim.bo.autoindent = false
    end,
  })
end
