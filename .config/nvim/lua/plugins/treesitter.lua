local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
    return
end

configs.setup({
    ensure_installed = { "lua", "bash", "c" },
    auto_install = true,
    autopairs = {
        enable = false,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
})
