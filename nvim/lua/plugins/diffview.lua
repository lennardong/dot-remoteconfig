-- Git diff UI: file-tree sidebar of changes, walk between files, edit inline.
-- Diffview over native difftool: one tabpage, file panel on the left, hunk nav;
-- the right pane is the REAL working file — edit + :w = real edit.
-- Terminal-only (gated off in VSCode, which has its own diff UI).
return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>",          desc = "Diff working tree" },
    { "<leader>gm", "<cmd>DiffviewOpen main<cr>",     desc = "Diff vs main (branch changes)" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history (current file)" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>",   desc = "Branch history" },
    { "<leader>gc", "<cmd>DiffviewClose<cr>",         desc = "Close diff" },
  },
  -- enhanced_diff_hl: word-level highlight inside changed lines.
  -- use_icons=false: text-only panel, skips nvim-web-devicons dep (icons are cosmetic).
  opts = { enhanced_diff_hl = true, use_icons = false },
}
