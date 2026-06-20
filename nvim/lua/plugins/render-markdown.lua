-- Markdown rendering: renders headings, lists, code blocks inline in buffer
-- Only loads for markdown filetype; requires treesitter markdown parsers
return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("render-markdown").setup({
      -- LaTeX math ($..$, $$..$$) renders to inline unicode via the `latex2text`
      -- CLI — must be on PATH: `uv tool install pylatexenc`. Without it, math
      -- silently stays raw while headings/tables still render.
      latex = { enabled = true },
      -- No embedded raw HTML in our markdown — disable to silence the missing
      -- `html` tree-sitter parser warning in :checkhealth.
      html = { enabled = false },
    })
  end,
}
