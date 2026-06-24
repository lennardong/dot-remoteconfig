-- Options — shared across VSCode and terminal

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.mouse = ""               -- disable mouse — keyboard-only, mirrors tmux mouse off
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
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#888888", bold = true })
  -- Active line: highlighter yellow, faked translucency (low-luminance tint lets
  -- text show through). Yellow stays unique against the green diff semantics.
  vim.api.nvim_set_hl(0, "CursorLine",   { bg = scheme:find("github_light") and "#f6efbe" or "#33300d" })
  -- Active-window tell: current line number glows highlighter yellow.
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffe600", bold = true })
  if scheme:find("github_light") then
    vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#444444", bg = "#b0b0b0" })
  end
  -- Diff highlights: faint bg only (no fg) so treesitter syntax shows through a
  -- big added block instead of rendering as one flat slab of green.
  -- faint line (DiffChange) + loud word (DiffText, stronger bg + bold) so a
  -- one-word change pops instead of blending into the changed line.
  local diff = scheme:find("github_light")
    and { add = "#d5f5e0", change = "#e2ecf7", text = "#8fdcab", delete = "#f7dada" }
    or  { add = "#1b3326", change = "#2a3b55", text = "#356b4d", delete = "#3a2024" }
  vim.api.nvim_set_hl(0, "DiffAdd",    { bg = diff.add })
  vim.api.nvim_set_hl(0, "DiffChange", { bg = diff.change })
  vim.api.nvim_set_hl(0, "DiffText",   { bg = diff.text, bold = true })
  vim.api.nvim_set_hl(0, "DiffDelete", { bg = diff.delete })
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_split_highlights })
apply_split_highlights()

-- Active-only cursorline: the highlighted line shows in the focused split only,
-- so the active window is obvious at a glance. cursorline=true (theme.lua) is the
-- default; these autocmds turn it off everywhere but the window you're in.
local active_cl = vim.api.nvim_create_augroup("ActiveCursorLine", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = active_cl, callback = function() vim.opt_local.cursorline = true end,
})
vim.api.nvim_create_autocmd("WinLeave", {
  group = active_cl, callback = function() vim.opt_local.cursorline = false end,
})

-- Diagnostics: show virtual line only for current line (nvim 0.11+)
vim.diagnostic.config({ virtual_lines = { current_line = true } })

-- Always-equal splits: equalalways handles open/close; VimResized handles
-- terminal resize (nvim scales proportionally otherwise).
vim.o.equalalways = true
vim.api.nvim_create_autocmd("VimResized", { command = "wincmd =" })
