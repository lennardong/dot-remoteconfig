-- Theme: toggle dark/light with <leader>tt
-- Comment/uncomment the colorscheme line below to set startup default
local function apply_cursor(scheme)
  if scheme == "github_light" then
    -- Neon green cursor — visible on light backgrounds
    vim.api.nvim_set_hl(0, "Cursor", { fg = "#ffffff", bg = "#00e676" })
    vim.api.nvim_set_hl(0, "CursorIM", { fg = "#ffffff", bg = "#00e676" })
    vim.opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr:hor20-Cursor"
  else
    -- Restore terminal default
    vim.api.nvim_set_hl(0, "Cursor", {})
    vim.api.nvim_set_hl(0, "CursorIM", {})
    vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
  end
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
