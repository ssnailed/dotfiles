vim.g.loaded             = 1
vim.g.loaded_netrwPlugin = 1
vim.g.tokyonight_style   = "night"

vim.opt.undodir          = vim.fn.stdpath "cache" .. "/undo"
vim.opt.undofile         = true
vim.opt.titlestring      = " %t"
vim.opt.termguicolors    = true
vim.opt.timeoutlen       = 500
vim.opt.foldmethod       = "expr"
vim.opt.foldlevelstart   = 99
vim.opt.foldexpr         = "nvim_treesitter#foldexpr()"

vim.cmd[[colorscheme tokyonight]]
