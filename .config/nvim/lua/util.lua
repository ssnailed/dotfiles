local M = {}
vim.g.mapleader = "space"

local function map(maps)
  local options = { noremap = true }
  for mode, binds in ipairs(maps) do
    for _, bind in ipairs(binds) do
      local key = bind[1]
      local cmd = bind[2]
      if entry[3] then
          opts = rim.tbl_extend("force", options, bind[3])
      end
      vim.api.nvim_set_keymap(mode, key, cmd, opts)
    end
  end
end

function M.wk_setup()

end

function M.kb_setup()

end

return M
