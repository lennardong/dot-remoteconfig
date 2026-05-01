-- Dim inactive splits by desaturating all highlight groups
-- tint = darkness amount (-50 = darker), saturation = colour muting
return {
  "levouh/tint.nvim",
  config = function()
    require("tint").setup({
      tint = -50,
      saturation = 0.2,
    })
  end,
}
