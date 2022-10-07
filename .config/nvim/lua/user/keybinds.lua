local opts = { silent = true, noremap=true }

vim.g.mapleader = "space"

maps = {
  n = { -- normal mode
    -- Better window navigation
    {"<C-h>", "<C-w>h", opts},
    {"<C-j>", "<C-w>j", opts},
    {"<C-k>", "<C-w>k", opts},
    {"<C-l>", "<C-w>l", opts},
    -- Resize with arrows
    {"<C-Up>", ":resize -2<CR>", opts},
    {"<C-Down>", ":resize +2<CR>", opts},
    {"<C-Left>", ":vertical resize -2<CR>", opts},
    {"<C-Right>", ":vertical resize +2<CR>", opts},
    -- Navigate buffers
    {"<S-l>", ":bnext<CR>", opts},
    {"<S-h>", ":bprevious<CR>", opts},
    -- Clear highlights
    {"<leader>h", "<cmd>nohlsearch<CR>", opts},
    -- Close buffers
    {"<S-q>", "<cmd>Bdelete!<CR>", opts},
    -- NvimTree
    {"<leader>e", ":NvimTreeToggle<CR>", opts},
    -- Telescope
    {"<leader>ff", ":Telescope find_files<CR>", opts},
    {"<leader>ft", ":Telescope live_grep<CR>", opts},
    {"<leader>fp", ":Telescope projects<CR>", opts},
    {"<leader>fb", ":Telescope buffers<CR>", opts},
    -- Git
    {"<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts},
    -- Comment
    {"<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts},
    -- DAP
    {"<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts},
    {"<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts},
    {"<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts},
    {"<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts},
    {"<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts},
    {"<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts},
    {"<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts},
    {"<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts},
    {"<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts},
    -- Illuminate
    {'<a-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', opts},
    {'<a-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', opts},
  },
  i = { -- insert mode
  },
  v = { -- visual mode
    -- Better paste
    {"p", '"_dP'},
    -- Stay in indent mode
    {"<", "<gv"},
    {">", ">gv"},
  },
  x = { -- visual block mode
    -- Comment
    {"<leader>/", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>', opts},
  },
  t = { -- terminal mode
  },
  c = { -- command mode
  }
}

for mode, binds in ipairs(maps) do
  for _, bind in ipairs(binds) do
    local key = bind[1]
    local cmd = bind[2]
    if entry[3] then
      local opt = entry[3]
    end
    vim.api.nvim_set_keymap(mode, key, cmd, opt)
  end
end
