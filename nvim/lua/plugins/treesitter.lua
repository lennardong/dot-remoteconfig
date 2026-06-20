-- Treesitter: parser installer + queries for nvim's built-in TS highlighter.
-- Uses the new `main` branch API (post-rewrite, requires nvim 0.12+).
-- Highlighting must be explicitly enabled per filetype via FileType autocmd.
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    ts.setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    local parsers = {
      "python", "lua", "bash", "toml", "yaml", "json",
      "dockerfile", "markdown", "markdown_inline", "latex",
    }
    ts.install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = parsers,
      callback = function() pcall(vim.treesitter.start) end,
    })
  end,
}
