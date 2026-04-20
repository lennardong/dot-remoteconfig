-- Theme: toggle dark/light with <leader>tt
-- Comment/uncomment the colorscheme line below to set startup default
local function apply_cursor()
  vim.api.nvim_set_hl(0, "Cursor",   { fg = "#ffffff", bg = "#00e676" })
  vim.api.nvim_set_hl(0, "CursorIM", { fg = "#ffffff", bg = "#00e676" })
  vim.opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr:hor20-Cursor"
end

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

    apply_cursor(vim.g.colors_name)
    _G.apply_cursor = apply_cursor
    vim.opt.cursorline = true
  end,
}
