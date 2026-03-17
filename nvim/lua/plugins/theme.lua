return {
  "Mofiqul/dracula.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd("colorscheme dracula")

    -- Dim non-current windows so focus is obvious
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "#21222c" })

    -- Yellow cursorline in active window
    vim.opt.cursorline = true
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#4a4400" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#f1fa8c", bold = true })
  end,
}
