vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  pattern = "*",
  command="if &nu && mode() != \"i\" | set rnu   | endif"
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  pattern = "*",
  command="if &nu | set nornu | endif"
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    require("nvim-treesitter.highlight").attach(0, "bash")
  end
})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  command = "hi FloatermBorder guibg=none"
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "bm-files", "bm-dirs" },
  command = "!shortcuts"
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "Xresources", "Xdefaults", "xresources", "xdefaults" },
  command = "set filetype=xdefaults"
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "Xresources", "Xdefaults", "xresources", "xdefaults" },
  command = "!xrdb %"
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "~/.local/src/dwmblocks/config.h",
  command = "!cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }"
})

vim.api.nvim_create_autocmd({ "BufDelete", "VimLeave" }, {
  pattern = "*.tex",
  command = "!texclear \"%:p\""
})

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
