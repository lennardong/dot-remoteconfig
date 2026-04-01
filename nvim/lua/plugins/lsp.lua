return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.config("basedpyright", {
      capabilities = { general = { positionEncodings = { "utf-16" } } },
    })
    vim.lsp.config("ruff", {
      capabilities = { general = { positionEncodings = { "utf-16" } } },
    })
    vim.lsp.config("marksman", {})
    vim.lsp.enable({ "basedpyright", "ruff", "marksman" })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- ruff handles linting only, not hover
        if client and client.name == "ruff" then
          client.server_capabilities.hoverProvider = false
        end

        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = args.buf, desc = desc })
        end
        map("gd", vim.lsp.buf.definition, "Definition")
        map("gr", vim.lsp.buf.references, "References")
        map("gh", vim.lsp.buf.hover, "Hover Docs")
        map("<leader>rs", vim.lsp.buf.rename, "Rename Symbol")
        map("<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols")
      end,
    })
  end,
}
