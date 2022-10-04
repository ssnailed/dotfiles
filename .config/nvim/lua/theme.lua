return function()
  require("tokyonight").setup({
    transparent = true,
    terminal_colors = true,
    dim_inactive = true,
    lualine_bold = true,
  })
  vim.cmd[[colorscheme tokyonight]]
end
