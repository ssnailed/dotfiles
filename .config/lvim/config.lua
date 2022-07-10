-- general
lvim.log.level                            = "warn"
lvim.colorscheme                          = "tokyonight"
vim.g.tokyonight_style                    = "night"
lvim.transparent_window                   = true
vim.opt.undodir                           = vim.fn.stdpath "cache" .. "/undo"
vim.opt.undofile                          = true
vim.opt.titlestring                       = "%t - vim"
lvim.builtin.alpha.active                 = true
lvim.builtin.alpha.mode                   = "dashboard"
lvim.builtin.terminal.active              = true
lvim.builtin.nvimtree.active              = false
lvim.builtin.treesitter.highlight.enabled = true
lvim.lsp.automatic_servers_installation   = false
vim.g.NERDTreeHijackNetrw                 = 0
vim.g.lf_replace_netrw                    = 1
lvim.format_on_save                       = false

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    require("nvim-treesitter.highlight").attach(0, "bash")
  end
})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd("hi FloatermBorder guibg=none")
  end
})

-- Lualine
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
  { "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  { "felipec/vim-sanegx",
    event = "BufRead",
  },
  { "ptzz/lf.vim",
    requires = "voldikss/vim-floaterm",
  },
  { "vimwiki/vimwiki" }
}

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.insert_mode = {
  ["<c-s>"] = "<ESC>:w<CR>i<Right>",
  ["<c-q>"] = "<ESC>:bd<CR>"
}
lvim.keys.normal_mode = {
  ["<c-s>"] = ":w<CR>",
  ["<c-q>"] = ":bd<CR>",
}
lvim.keys.term_mode = {
  ["<c-q>"] = ":bd<CR>"
}
lvim.keys.visual_mode = {
  ["<c-s>"] = "<ESC>:w<CR>",
  ["<c-q>"] = "<ESC>:bd<CR>",
  ["<"] = "<gv",
  [">"] = ">gv",
}
lvim.keys.visual_block_mode = {
  ["<c-s>"] = "<ESC>:w<CR>",
  ["<c-q>"] = "<ESC>:bd<CR>",
  ["K"] = ":move '<-2<CR>gv-gv",
  ["J"] = ":move '>+1<CR>gv-gv",
}


lvim.builtin.which_key.mappings = {
  [";"] = { "<cmd>Alpha<CR>", "Dashboard" },
  ["/"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Comment" },
  ["f"] = { require("lvim.core.telescope.custom-finders").find_project_files, "Find File" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["e"] = { "<cmd>Lf<CR>", "List Files" },
  ["P"] = { "<cmd>Telescope projects<CR>", "Projects" },
  b     = {
    name = "Buffers",
    j = { "<cmd>BufferLinePick<cr>", "Jump" },
    f = { "<cmd>Telescope buffers<cr>", "Find" },
    b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
    n = { "<cmd>BufferLineCycleNext<cr>", "Next" },

    -- w = { "<cmd>BufferWipeout<cr>", "Wipeout" }, -- TODO: implement this for bufferline
    e = {
      "<cmd>BufferLinePickClose<cr>",
      "Pick which buffer to close",
    },
    h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
    l = {
      "<cmd>BufferLineCloseRight<cr>",
      "Close all to the right",
    },
    D = {
      "<cmd>BufferLineSortByDirectory<cr>",
      "Sort by directory",
    },
    L = {
      "<cmd>BufferLineSortByExtension<cr>",
      "Sort by language",
    },
  },
  p     = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    r = { "<cmd>lua require('lvim.plugin-loader').recompile()<cr>", "Re-compile" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  -- " Available Debug Adapters:
  -- "   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
  -- " Adapter configuration and installation instructions:
  -- "   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
  -- " Debug Adapter protocol:
  -- "   https://microsoft.github.io/debug-adapter-protocol/
  -- " Debugging
  g = {
    name = "Git",
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    C = {
      "<cmd>Telescope git_bcommits<cr>",
      "Checkout commit(for current file)",
    },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Git Diff",
    },
  },
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
    w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
    f = { require("lvim.lsp.utils").format, "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      vim.diagnostic.goto_next,
      "Next Diagnostic",
    },
    k = {
      vim.diagnostic.goto_prev,
      "Prev Diagnostic",
    },
    l = { vim.lsp.codelens.run, "CodeLens Action" },
    p = {
      name = "Peek",
      d = { "<cmd>lua require('lvim.lsp.peek').Peek('definition')<cr>", "Definition" },
      t = { "<cmd>lua require('lvim.lsp.peek').Peek('typeDefinition')<cr>", "Type Definition" },
      i = { "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>", "Implementation" },
    },
    q = { vim.diagnostic.setloclist, "Quickfix" },
    r = { vim.lsp.buf.rename, "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
    e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
  },
  L = {
    name = "LunarVim",
    c = {
      "<cmd>edit " .. get_config_dir() .. "/config.lua<cr>",
      "Edit config.lua",
    },
    f = {
      "<cmd>lua require('lvim.core.telescope.custom-finders').find_lunarvim_files()<cr>",
      "Find LunarVim files",
    },
    g = {
      "<cmd>lua require('lvim.core.telescope.custom-finders').grep_lunarvim_files()<cr>",
      "Grep LunarVim files",
    },
    k = { "<cmd>Telescope keymaps<cr>", "View LunarVim's keymappings" },
    i = {
      "<cmd>lua require('lvim.core.info').toggle_popup(vim.bo.filetype)<cr>",
      "Toggle LunarVim Info",
    },
    I = {
      "<cmd>lua require('lvim.core.telescope.custom-finders').view_lunarvim_changelog()<cr>",
      "View LunarVim's changelog",
    },
    l = {
      name = "+logs",
      d = {
        "<cmd>lua require('lvim.core.terminal').toggle_log_view(require('lvim.core.log').get_path())<cr>",
        "view default log",
      },
      D = {
        "<cmd>lua vim.fn.execute('edit ' .. require('lvim.core.log').get_path())<cr>",
        "Open the default logfile",
      },
      l = {
        "<cmd>lua require('lvim.core.terminal').toggle_log_view(vim.lsp.get_log_path())<cr>",
        "view lsp log",
      },
      L = { "<cmd>lua vim.fn.execute('edit ' .. vim.lsp.get_log_path())<cr>", "Open the LSP logfile" },
      n = {
        "<cmd>lua require('lvim.core.terminal').toggle_log_view(os.getenv('NVIM_LOG_FILE'))<cr>",
        "view neovim log",
      },
      N = { "<cmd>edit $NVIM_LOG_FILE<cr>", "Open the Neovim logfile" },
      p = {
        "<cmd>lua require('lvim.core.terminal').toggle_log_view(get_cache_dir() .. '/packer.nvim.log')<cr>",
        "view packer log",
      },
      P = { "<cmd>edit $LUNARVIM_CACHE_DIR/packer.nvim.log<cr>", "Open the Packer logfile" },
    },
    n = { "<cmd>Telescope notify<cr>", "View Notifications" },
    r = { "<cmd>LvimReload<cr>", "Reload LunarVim's configuration" },
    u = { "<cmd>LvimUpdate<cr>", "Update LunarVim" },
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    t = { "<cmd>Telescope live_grep<cr>", "Text" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    p = {
      "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
      "Colorscheme with Preview",
    },
  },
  T = {
    name = "Treesitter",
    i = { ":TSConfigInfo<cr>", "Info" },
  },
  w = { name = "VimWiki" }
}
