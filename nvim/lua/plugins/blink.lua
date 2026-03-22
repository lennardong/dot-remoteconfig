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
