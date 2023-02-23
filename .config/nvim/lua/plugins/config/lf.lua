local status_ok, lf = pcall(require, 'lf')
if not status_ok then
    return
end

lf.setup({
    mappings = false,
    winblend = 0,
    border = "rounded",
})
