return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = {
        "python", "lua", "bash", "toml", "yaml", "json",
        "dockerfile", "markdown", "markdown_inline",
      },
    })
  end,
}
