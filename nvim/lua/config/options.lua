-- Options — shared across VSCode and terminal

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.relativenumber = true
vim.opt.clipboard:append("unnamedplus")
vim.opt.scrolloff = 8
vim.opt.wrap = true
vim.opt.linebreak = true         -- wrap at word boundaries, not mid-word
vim.opt.breakindent = true       -- visually indent wrapped lines
vim.opt.breakindentopt = "shift:4"  -- 4-space offset for wrapped continuation
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.autowriteall = true      -- save on buffer switch, :quit, etc.
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true  -- persistent undo is a better safety net than swap
vim.opt.autoread = true -- reload buffers changed outside nvim

-- Diagnostics: show virtual line only for current line (nvim 0.11+)
vim.diagnostic.config({ virtual_lines = { current_line = true } })
