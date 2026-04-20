-- Options — shared across VSCode and terminal

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.relativenumber = true
vim.opt.clipboard:append("unnamedplus")
vim.opt.scrolloff = 8
vim.opt.wrap = true
vim.opt.linebreak = true         -- wrap at word boundaries, not mid-word
vim.opt.breakindent = true       -- visually indent wrapped lines
vim.opt.breakindentopt = "shift:4"  -- 4-space offset for wrapped continuation
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.splitright = true   -- vertical split opens right
vim.opt.splitbelow = true   -- horizontal split opens below
vim.opt.autowriteall = true      -- save on buffer switch, :quit, etc.
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true  -- persistent undo is a better safety net than swap
vim.opt.autoread = true -- reload buffers changed outside nvim

-- Split dividers: solid line characters
vim.opt.fillchars:append({ vert = "│", horiz = "─", horizup = "┴", horizdown = "┬", vertleft = "┤", vertright = "├", verthoriz = "┼" })

-- Re-apply after every colorscheme load (themes wipe set_hl on load)
local function apply_split_highlights()
  local scheme = vim.g.colors_name or ""
  if scheme:find("github_light") then
    vim.api.nvim_set_hl(0, "NormalNC",     { bg = "#d0d0d0" })
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#888888", bold = true })
    vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#444444", bg = "#b0b0b0" })
    vim.api.nvim_set_hl(0, "CursorLine",   { bg = "#c8f0d8" })
  else
    vim.api.nvim_set_hl(0, "NormalNC",     { bg = "#1a1b26" })
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#888888", bold = true })
    vim.api.nvim_set_hl(0, "CursorLine",   { bg = "#1e3a2a" })
  end
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_split_highlights })
apply_split_highlights()

-- Diagnostics: show virtual line only for current line (nvim 0.11+)
vim.diagnostic.config({ virtual_lines = { current_line = true } })
