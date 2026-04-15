-- Theme: Dracula colorscheme with cursorline
-- Loaded first (priority 1000) so other plugins inherit highlight groups
return {
  "Mofiqul/dracula.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("dracula").setup({})
    vim.cmd("colorscheme dracula")
    vim.opt.cursorline = true
  end,
}
