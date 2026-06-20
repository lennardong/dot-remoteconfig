-- Match tmux's inactive pane background across all splits.
--
-- tmux paints unfocused panes 'bg=colour233' (tmux.conf), but nvim draws its own
-- Normal bg over the whole pane so tmux can't show through. We listen for tmux
-- focus events (focus-events on) and repaint nvim ourselves: on focus loss every
-- split goes to colour233, on focus gain the colorscheme bg is restored.

local INACTIVE_BG = "#121212" -- xterm colour233, matches tmux window-style

-- Colorscheme's real fg/bg, refreshed on theme change so the <leader>tt toggle
-- keeps restoring the right colours. link=false resolves NormalNC's link.
local saved = {}
local function capture()
  for _, g in ipairs({ "Normal", "NormalNC" }) do
    local hl = vim.api.nvim_get_hl(0, { name = g, link = false })
    saved[g] = { fg = hl.fg, bg = hl.bg }
  end
end

local function dim()
  for _, g in ipairs({ "Normal", "NormalNC" }) do
    vim.api.nvim_set_hl(0, g, { fg = (saved[g] or {}).fg, bg = INACTIVE_BG })
  end
end

local function undim()
  for _, g in ipairs({ "Normal", "NormalNC" }) do
    if saved[g] then vim.api.nvim_set_hl(0, g, { fg = saved[g].fg, bg = saved[g].bg }) end
  end
end

local group = vim.api.nvim_create_augroup("DimPaneOnTmuxFocus", { clear = true })
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, { group = group, callback = capture })
vim.api.nvim_create_autocmd("FocusLost", { group = group, callback = dim })
vim.api.nvim_create_autocmd("FocusGained", { group = group, callback = undim })
