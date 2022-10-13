maps = require('keymaplist').kb
vim.keymap.set("", "<Space>", "<Nop>", { silent = true, noremap = true })
vim.g.mapleader = " "
for mode, binds in pairs(maps) do
  for _, bind in pairs(binds) do
    local key = bind[1]
    local cmd = bind[2]
    local opt = bind[3]
    vim.api.nvim_set_keymap(mode, key, cmd, opt)
  end
end
