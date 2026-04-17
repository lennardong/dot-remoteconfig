-- LSP: language server configs for Python and Markdown
-- basedpyright for type checking, ruff for linting (hover disabled to avoid conflicts)
-- marksman for Markdown link/heading navigation
-- Uses nvim 0.11+ vim.lsp.config/enable pattern (no mason, no lsp-zero)
return {
  "neovim/nvim-lspconfig",
  config = function()
    -- basedpyright returns inlay hint positions that exceed line length,
    -- causing nvim_buf_set_extmark to error. Clamp columns to line length.
    local orig_inlay = vim.lsp.handlers["textDocument/inlayHint"]
    vim.lsp.handlers["textDocument/inlayHint"] = function(err, result, ctx, config)
      if result then
        local lines = vim.api.nvim_buf_get_lines(ctx.bufnr, 0, -1, false)
        for _, hint in ipairs(result) do
          local line = hint.position.line
          local col = hint.position.character
          local line_len = lines[line + 1] and #lines[line + 1] or 0
          if col > line_len then
            hint.position.character = line_len
          end
        end
      end
      orig_inlay(err, result, ctx, config)
    end

    vim.lsp.config("basedpyright", {
      capabilities = { general = { positionEncodings = { "utf-16" } } },
      settings = {
        basedpyright = {
          analysis = {
            inlayHints = {
              variableTypes = false,
              callArgumentNames = true,
              functionReturnTypes = true,
              genericTypes = false,
            },
          },
        },
      },
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

        -- enable inlay type hints when supported
        if client and client:supports_method("textDocument/inlayHint") then
          vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end

        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = args.buf, desc = desc })
        end
        map("gd", vim.lsp.buf.definition, "Definition")
        map("gr", vim.lsp.buf.references, "References")
        map("gh", vim.lsp.buf.hover, "Hover Docs")
        map("<leader>rs", vim.lsp.buf.rename, "Rename Symbol")
        map("<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols")
        map("<leader>th", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }), { bufnr = args.buf })
        end, "Toggle Inlay Hints")
      end,
    })
  end,
}
