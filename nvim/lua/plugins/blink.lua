-- Completion: inline suggestions from LSP, paths, and buffer words
-- blink.cmp over nvim-cmp: faster (Rust fuzzy matcher), simpler config
-- Tab to accept, C-space to trigger manually, Up/Down to navigate
return {
  "saghen/blink.cmp",
  version = "1.*",
  opts = {
    keymap = {
      ["<Tab>"] = { "accept", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-e>"] = { "cancel" },
      ["<C-space>"] = { "show" },
    },
    completion = {
      documentation = { auto_show = true },
    },
    sources = {
      default = { "lsp", "path", "buffer" },
    },
  },
}
