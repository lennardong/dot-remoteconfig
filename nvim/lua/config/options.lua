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
vim.opt.winwidth    = 999   -- active split takes max available width
vim.opt.winheight   = 999   -- active split takes max available height
vim.opt.winminwidth  = 80   -- inactive splits stay at least this wide
vim.opt.winminheight = 10    -- inactive splits stay at least this tall
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
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#888888", bold = true })
  vim.api.nvim_set_hl(0, "CursorLine",   { bg = scheme:find("github_light") and "#c8f0d8" or "#1e3a2a" })
  if scheme:find("github_light") then
    vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#444444", bg = "#b0b0b0" })
  end
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_split_highlights })
apply_split_highlights()

-- Diagnostics: show virtual line only for current line (nvim 0.11+)
vim.diagnostic.config({ virtual_lines = { current_line = true } })
