local themes = {
  { scheme = "dracula",       style = nil, bg = "dark" },
  { scheme = "dracula-light", style = nil, bg = "dark" },
  { scheme = "material", style = "deep ocean", bg = "dark" },
  { scheme = "material", style = "oceanic",    bg = "dark" },
  { scheme = "material", style = "palenight",  bg = "dark" },
  { scheme = "material", style = "darker",     bg = "dark" },
  { scheme = "material", style = "lighter",    bg = "light" },
}

local overrides = {
  dark  = { bg = "#282a36", nc = "#0a0e14", float = "#282a36", line = "#4a4400", nr = "#ffcb6b" },
  light = { bg = nil,       nc = "#e0e0e0", float = nil,       line = "#e0e0e0", nr = "#616161" },
}

local idx = 1

local function apply(i)
  idx = i
  local t = themes[idx]
  if t.style then vim.g.material_style = t.style end
  vim.o.background = t.bg
  vim.cmd("colorscheme " .. t.scheme)

  local o = overrides[t.bg]
  if o.bg then
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = o.float })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = o.float })
  end
  vim.api.nvim_set_hl(0, "NormalNC", { bg = o.nc })
  vim.api.nvim_set_hl(0, "CursorLine", { bg = o.line })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = o.nr, bold = true })

  vim.notify(t.style and (t.scheme .. " " .. t.style) or t.scheme, vim.log.levels.INFO)
end

local function next_theme()
  apply(idx % #themes + 1)
end

local function toggle_light()
  local target_bg = vim.o.background == "dark" and "light" or "dark"
  for i, t in ipairs(themes) do
    if t.bg == target_bg then return apply(i) end
  end
end

return {
  { "Mofiqul/dracula.nvim",       lazy = false, priority = 999 },
  {
    "marko-cerovac/material.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("material").setup({
        styles = { comments = { italic = true } },
        plugins = { "nvim-cmp", "telescope", "which-key" },
      })

      vim.opt.cursorline = true
      apply(1)

      vim.api.nvim_create_user_command("Theme", next_theme, {})
      vim.api.nvim_create_user_command("Light", toggle_light, {})
      vim.keymap.set("n", "<leader>ts", ":Theme<CR>", { desc = "Cycle theme", silent = true })
      vim.keymap.set("n", "<leader>tl", ":Light<CR>", { desc = "Toggle light/dark", silent = true })
    end,
  },
}
