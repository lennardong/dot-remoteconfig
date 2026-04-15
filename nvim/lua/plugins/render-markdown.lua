-- Markdown rendering: renders headings, lists, code blocks inline in buffer
-- Only loads for markdown filetype; requires treesitter markdown parsers
return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("render-markdown").setup({})
  end,
}
