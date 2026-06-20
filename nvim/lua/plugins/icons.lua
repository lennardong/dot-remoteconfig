-- Nerd Font icon provider. One dep, two consumers:
--   oil      -> reads mini.icons natively (its preferred provider)
--   diffview -> expects nvim-web-devicons; the mock shims that API onto mini.icons
-- lazy runs this config before any plugin that lists mini.icons as a dependency,
-- so both get icons regardless of load order. Needs a Nerd Font in the terminal.
return {
  "echasnovski/mini.icons",
  lazy = true,
  config = function()
    require("mini.icons").setup()
    MiniIcons.mock_nvim_web_devicons()
  end,
}
