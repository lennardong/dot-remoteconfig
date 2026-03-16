return {
  "justinmk/vim-sneak",
  event = "VeryLazy",
  init = function()
    vim.g["sneak#label"] = 1
    vim.g["sneak#use_ic_scs"] = 1
    vim.g["sneak#label_esc"] = "<CR>"
  end,
  config = function()
    vim.keymap.set("n", "cl", "s") -- preserve original s via cl

    -- Sneak overrides n/N for repeat
    vim.keymap.set("n", "n", "<Plug>Sneak_;zzzv", { remap = true, silent = true })
    vim.keymap.set("n", "N", "<Plug>Sneak_,zzzv", { remap = true, silent = true })
  end,
}
