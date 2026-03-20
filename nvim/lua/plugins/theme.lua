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
