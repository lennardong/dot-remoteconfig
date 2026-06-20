-- Git diff UI: file-tree sidebar of changes, walk between files, edit inline.
-- Diffview over native difftool: one tabpage, file panel on the left, hunk nav;
-- the right pane is the REAL working file — edit + :w = real edit.
-- Terminal-only (gated off in VSCode, which has its own diff UI).
return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "echasnovski/mini.icons" },
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>",          desc = "Diff working tree" },
    -- Diff vs the repo's trunk, resolved dynamically from origin/HEAD
    -- (uat here, main/master elsewhere). ponytail: relies on origin/HEAD being
    -- set; if detached/no-remote it notifies. Fix once: git remote set-head origin -a
    { "<leader>gm", function()
      local out = vim.fn.systemlist("git symbolic-ref --quiet --short refs/remotes/origin/HEAD")
      local trunk = out[1] and out[1]:gsub("^origin/", "")
      if not trunk or trunk == "" then
        vim.notify("No origin/HEAD — run: git remote set-head origin -a", vim.log.levels.WARN)
        return
      end
      vim.cmd("DiffviewOpen " .. trunk)
    end, desc = "Diff vs trunk (branch changes)" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history (current file)" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>",   desc = "Branch history" },
    { "<leader>gc", "<cmd>DiffviewClose<cr>",         desc = "Close diff" },
  },
  -- enhanced_diff_hl: word-level highlight inside changed lines.
  -- use_icons=true: file-type icons in the panel via mini.icons' devicons shim.
  -- listing_style="list": flat file panel, no directory tree.
  opts = {
    enhanced_diff_hl = true,
    use_icons = true,
    file_panel = { listing_style = "list" },
  },
}
