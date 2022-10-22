-- custom formatters and diagnostic clients are handled by null-ls
-- they can be configured in the null-ls plugin config file
return {
  ["sumneko_lua"] = {
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
  },
  ["bashls"] = {
  },
  ["clangd"] = {
  },
}
