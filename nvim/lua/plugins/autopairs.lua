-- Autopairs: auto-close brackets, quotes, etc. on InsertEnter
-- Uses mini.pairs over nvim-autopairs: fewer lines, no deps, LazyVim default
-- Handles: () [] {} "" '' ``
-- Smart: skips closing when cursor is already before a matching closer
return {
  "echasnovski/mini.pairs",
  event = "InsertEnter",
  opts = {},
}
