local status_ok, tokyonight = pcall(require, 'tokyonight')
if not status_ok then
    return
end

tokyonight.setup({
    style = "night",
    transparent = true,
    terminal_colors = true,
    dim_inactive = true,
})
vim.cmd [[colorscheme tokyonight]]
