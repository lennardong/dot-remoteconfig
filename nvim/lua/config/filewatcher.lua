-- File watcher: auto-reload buffers when external tools (Claude Code, aider) modify files
-- Requires vim.opt.autoread = true

local w = vim.uv.new_fs_event()
if not w then return end

local root = vim.fn.getcwd()

w:start(root, { recursive = true }, function(err, filename)
  if err then return end
  if not filename then return end

  -- Skip noise: .git internals, __pycache__, .venv, node_modules
  if filename:match("^%.git/")
    or filename:match("__pycache__")
    or filename:match("%.venv")
    or filename:match("node_modules") then
    return
  end

  -- Schedule checktime on main loop (uv callback is off-thread)
  vim.schedule(function()
    if vim.api.nvim_get_mode().mode ~= "c" then
      vim.cmd("checktime")
    end
  end)
end)

-- Cleanup on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    if w and not w:is_closing() then w:stop(); w:close() end
  end,
})
