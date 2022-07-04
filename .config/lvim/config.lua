-- general
lvim.log.level          = "warn"
lvim.colorscheme        = "tokyonight"
lvim.transparent_window = true
vim.opt.undodir         = vim.fn.stdpath "cache" .. "/undo"
vim.opt.undofile        = true
vim.opt.titlestring     = "%<%F%=%l/%L - nvim"

-- Lualine
lvim.builtin.lualine.style = "none"
local components = require "lvim.core.lualine.components"
local colors = require "lvim.core.lualine.colors"
components.scrollbar = {
  function()
    local current_line = vim.fn.line "."
    local total_lines = vim.fn.line "$"
    local chars = { "", "", "", "", "", "", "", "", "", "", "", "", "" }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
  end,
  color = { fg = colors.yellow },
  cond = nil,
}
lvim.builtin.lualine.options = {
  component_separators = { left = '', right = '' },
  section_separators = { left = '', right = '' },
}
lvim.builtin.lualine.sections = {
  lualine_a = { components.filename },
  lualine_b = { components.scrollbar, components.location },
  lualine_c = { components.branch, components.diff },
  lualine_x = { components.python_env, components.spaces },
  lualine_y = { components.treesitter, components.diagnostics, components.lsp },
  lualine_z = { components.encoding, components.filetype },
}

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}
lvim.builtin.which_key.mappings["e"] = { "<cmd>LfNewTab<CR>", "Explorer" }
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- parsers
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "json",
  "lua",
  "python",
  "yaml",
}

lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
lvim.lsp.automatic_servers_installation = false

-- formatters
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
}

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
-- }

-- Plugins
lvim.plugins = {
  { "folke/tokyonight.nvim" },
  { "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("numb").setup {
        show_numbers = true,
        show_cursorline = true,
      }
    end,
  },
  { "sindrets/diffview.nvim",
    event = "BufRead",
  },
  { "metakirby5/codi.vim",
    cmd = "Codi",
  },
  { "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  { "tpope/vim-repeat" },
  {
    "felipec/vim-sanegx",
    event = "BufRead",
  },
  --  { "tpope/vim-surround",
  --    keys = { "c", "d", "y" },
  --    -- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
  --    setup = function()
  --      vim.opt.timeoutlen = 500
  --    end
  --  },
  { "ptzz/lf.vim",
    config = function()
      vim.api.nvim_set_var("NERDTreeHijackNetrw", 0)
      vim.api.nvim_set_var("lf_replace_netrw", 1)
      vim.api.nvim_set_var("lf_command_override", 'lf -command "set nopreview" -command "set hidden"')
    end,
  },
  { "voldikss/vim-floaterm" },
  { "vimwiki/vimwiki" }
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    -- let treesitter use bash highlight for zsh files as well
    require("nvim-treesitter.highlight").attach(0, "bash")
  end
})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd("hi FloatermBorder guibg=none")
  end
})
