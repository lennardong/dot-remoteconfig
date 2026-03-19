-- VSCode-specific keymaps and autocmds

local function vscode_notify(cmd)
  return function() vim.fn.VSCodeNotify(cmd) end
end

-- Ensure no plugin hijacks <CR> in insert mode
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.schedule(function()
      vim.keymap.set("i", "<CR>", "<CR>", { noremap = true })
    end)
  end,
})

-- Disable neovim's indent engine — VS Code owns indentation.
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.bo.indentexpr = ""
    vim.bo.indentkeys = ""
    vim.bo.smartindent = false
    vim.bo.autoindent = false
  end,
})

-- Command palette
vim.keymap.set("n", "<leader>cp", vscode_notify("workbench.action.showCommands"))

-- LSP (default-style)
vim.keymap.set("n", "gd", vscode_notify("editor.action.revealDefinition"), { desc = "Definition" })
vim.keymap.set("n", "gr", vscode_notify("editor.action.goToReferences"), { desc = "References" })
vim.keymap.set("n", "gh", vscode_notify("editor.action.showHover"), { desc = "Hover Docs" })
vim.keymap.set("n", "<leader>rs", vscode_notify("editor.action.rename"), { desc = "Rename Symbol" })

-- Symbols
vim.keymap.set("n", "<leader>ds", vscode_notify("workbench.action.gotoSymbol"), { desc = "Document Symbols" })
vim.keymap.set("n", "<leader>ws", vscode_notify("workbench.action.showAllSymbols"), { desc = "Workspace Symbols" })

-- Panel visibility (<leader>v)
vim.keymap.set("n", "<leader>vl", vscode_notify("workbench.action.toggleSidebarVisibility"))
vim.keymap.set("n", "<leader>vr", vscode_notify("workbench.action.toggleAuxiliaryBar"))
vim.keymap.set("n", "<leader>vb", vscode_notify("workbench.action.togglePanel"))
vim.keymap.set("n", "<leader>vw", vscode_notify("workbench.action.focusActiveEditorGroup"))

-- File navigation
vim.keymap.set("n", "<leader>ff", vscode_notify("workbench.action.quickOpen"))
vim.keymap.set("n", "<leader>fw", vscode_notify("workbench.action.findInFiles"))

-- Hide neovim statusline in VSCode
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.defer_fn(function()
      vim.api.nvim_set_option("laststatus", 0)
    end, 100)
  end,
})

-- Auto-save on buffer leave / focus lost
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  pattern = "*",
  callback = function()
    if vim.bo.modified and vim.bo.buftype == "" and vim.fn.filereadable(vim.fn.expand("%")) == 1 then
      vim.fn.VSCodeNotify("workbench.action.files.save")
    end
  end,
})
