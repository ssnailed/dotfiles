local null_ls_status_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_status_ok then
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- WARN: If this setup doesn't work it's probably because a different language server with a formatter is taking precedence
-- https://github.com/LunarVim/LunarVim/blob/master/lua/lvim/lsp/utils.lua#L172

null_ls.setup({
    debug = false,
    sources = {
        formatting.black.with { extra_args = { "--fast" } },
        formatting.shfmt,
        -- formatting.stylua,
        -- diagnostics.flake8,
    },
})
