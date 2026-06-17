-- Match tmux's inactive pane background across ALL splits.
--
-- tmux paints unfocused panes 'bg=colour235' (tmux.conf), but nvim draws its own
-- Normal bg over the whole pane so tmux can't show through. We listen for tmux
-- focus events (focus-events on) and repaint nvim ourselves.
--
-- tint.nvim moves every window onto its own highlight namespace, so a plain
-- nvim_set_hl(0, ...) is invisible. We therefore tint.disable() on focus loss
-- (reverts all windows to namespace 0), paint Normal/NormalNC = colour235, then
-- re-enable tint on focus gain so inactive splits dim again while focused.

local INACTIVE_BG = "#262626" -- xterm colour235, matches tmux window-style

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
  pcall(function() require("tint").disable() end)
  for _, g in ipairs({ "Normal", "NormalNC" }) do
    vim.api.nvim_set_hl(0, g, { fg = (saved[g] or {}).fg, bg = INACTIVE_BG })
  end
end

local function undim()
  for _, g in ipairs({ "Normal", "NormalNC" }) do
    if saved[g] then vim.api.nvim_set_hl(0, g, { fg = saved[g].fg, bg = saved[g].bg }) end
  end
  pcall(function() require("tint").enable() end)
end

local group = vim.api.nvim_create_augroup("DimPaneOnTmuxFocus", { clear = true })
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, { group = group, callback = capture })
vim.api.nvim_create_autocmd("FocusLost", { group = group, callback = dim })
vim.api.nvim_create_autocmd("FocusGained", { group = group, callback = undim })
