-- All the custom lua functions

--  This function gets run when an LSP connects to a particular buffer.
local lsp_on_attach = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --- toggle inlay hints
  vim.g.inlay_hints_visible = true
  local function toggle_inlay_hints()
    if vim.g.inlay_hints_visible then
      vim.g.inlay_hints_visible = false
      vim.lsp.inlay_hint(bufnr, false)
    else
      if client.server_capabilities.inlayHintProvider then
        vim.g.inlay_hints_visible = true
        vim.lsp.inlay_hint(bufnr, true)
      else
        print("no inlay hints available")
      end
    end
  end

  --- toggle diagnostics
  vim.g.diagnostics_visible = true
  local function toggle_diagnostics()
    if vim.g.diagnostics_visible then
      vim.g.diagnostics_visible = false
      vim.diagnostic.enable(false)
    else
      vim.g.diagnostics_visible = true
      vim.diagnostic.enable()
    end
  end

  --- autocmd to show diagnostics on CursorHold
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    desc = "✨lsp show diagnostics on CursorHold",
    callback = function()
      local hover_opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "always",
        prefix = " ",
      }
      vim.diagnostic.open_float(nil, hover_opts)
    end,
  })

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

