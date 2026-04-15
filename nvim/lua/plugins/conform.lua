-- Formatting: auto-format on save via external formatters
-- ruff for Python (format + import sorting), mdformat for Markdown
-- Falls back to LSP formatting if no formatter configured for a filetype
return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    formatters_by_ft = {
      python   = { "ruff_format", "ruff_organize_imports" },
      markdown = { "mdformat" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
