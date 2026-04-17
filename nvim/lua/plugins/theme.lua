-- Theme: toggle dark/light with <leader>tt
-- Comment/uncomment the colorscheme line below to set startup default
return {
  "projekt0n/github-nvim-theme",
  lazy = false,
  priority = 1000,
  dependencies = { "Mofiqul/dracula.nvim" },
  config = function()
    require("github-theme").setup({})
    require("dracula").setup({})

    -- Startup theme — comment one, uncomment the other
    vim.cmd("colorscheme dracula")
    -- vim.cmd("colorscheme github_light")

    vim.opt.cursorline = true
  end,
}
