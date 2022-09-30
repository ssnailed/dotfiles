local opt = vim.opt

opt.undodir        = vim.fn.stdpath "cache" .. "/undo"
opt.undofile       = true
opt.titlestring    = " %t"
opt.termguicolors  = true
opt.timeoutlen     = 500
opt.foldmethod     = "expr"
opt.foldlevelstart = 99
opt.foldexpr       = "nvim_treesitter#foldexpr()"

return opt
