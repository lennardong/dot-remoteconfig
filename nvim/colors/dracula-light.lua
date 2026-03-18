-- Dracula with 20% brighter backgrounds
vim.cmd("colorscheme dracula")
vim.api.nvim_set_hl(0, "Normal",      { bg = "#3d3f48", fg = "#f8f8f2" })
vim.api.nvim_set_hl(0, "NormalNC",    { bg = "#33353e" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#3d3f48", fg = "#f8f8f2" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#3d3f48" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "#3d3f48" })
vim.api.nvim_set_hl(0, "LineNr",   { bg = "#3d3f48", fg = "#6272a4" })
vim.g.colors_name = "dracula-light"
