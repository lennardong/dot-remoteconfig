-- Treesitter: syntax-aware highlighting, indentation, and text objects
-- Parsers auto-installed for Python, Lua, Bash, config formats, and Markdown
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
