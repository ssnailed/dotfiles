local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_status_ok then
  return
end

local lspconfig_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status_ok then
  return
end

local on_attach = function(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local opts = {
  on_attach = on_attach,
  capabilities = capabilities
}

-- for server, config in pairs(servers) do
--   opts = {
--     on_attach = on_attach,
--     capabilities = capabilities
--   }
--   server = vim.split(server, "@")[1]
--   opts = vim.tbl_deep_extend("force", config, opts)
--   lspconfig[server].setup(opts)
-- end

mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
})

mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup(opts)
  end,
  ["sumneko_lua"] = function()
    opts = {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true
            },
          },
          telemetry = {
            enable = false,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    }
    lspconfig["sumneko_lua"].setup(opts)
  end
})
