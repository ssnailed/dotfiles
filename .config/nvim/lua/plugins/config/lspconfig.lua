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

mason_lspconfig.setup({
    ensure_installed = {},
    automatic_installation = true,
})

mason_lspconfig.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup(opts)
    end,
    ["intelephense"] = function()
        opts = {
            on_attach = on_attach,
            capabilities = capabilities,
            init_options = {
                storagePath = vim.fn.expand "$XDG_CACHE_HOME" .. "/intelephense",
                globalStoragePath = vim.fn.expand "$XDG_DATA_HOME" .. "/intelephense"
            },
            settings = {
                intelephense = {
                    telemetry = {
                        enable = false,
                    }
                }
            }
        }
        lspconfig["intelephense"].setup(opts)
    end,
    ["lua_ls"] = function()
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
        lspconfig["lua_ls"].setup(opts)
    end
})
