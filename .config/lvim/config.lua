-- general
lvim.log.level                            = "warn"
lvim.colorscheme                          = "tokyonight"
vim.g.tokyonight_style                    = "night"
vim.opt.undodir                           = vim.fn.stdpath "cache" .. "/undo"
vim.opt.undofile                          = true
vim.opt.titlestring                       = " %t"
vim.opt.termguicolors                     = true
vim.opt.timeoutlen                        = 500
lvim.builtin.alpha.active                 = true
lvim.builtin.alpha.mode                   = "dashboard"
lvim.builtin.terminal.active              = true
lvim.builtin.nvimtree.active              = false
lvim.builtin.treesitter.highlight.enabled = true
lvim.lsp.automatic_servers_installation   = false
vim.g.NERDTreeHijackNetrw                 = 0
vim.g.lf_replace_netrw                    = 1
vim.opt.foldmethod                        = "expr"
vim.opt.foldlevelstart                    = 99
vim.opt.foldexpr                          = "nvim_treesitter#foldexpr()"
lvim.format_on_save                       = false
lvim.line_wrap_cursor_movement            = false

-- Vimwiki Settings
vim.g.vimwiki_ext2syntax = { ['.Rmd'] = 'markdown', ['.rmd'] = 'markdown', ['.md'] = 'markdown',
  ['.markdown'] = 'markdown', ['.mdown'] = 'markdown' }
vim.g.vimwiki_list = { { ['path'] = '~/Documents/vimwiki', ['syntax'] = 'markdown', ['ext'] = '.md' } }

-- Completion settings
lvim.builtin.cmp.completion.keyword_length = 3
lvim.builtin.cmp.sources = {
  { name = "nvim_lsp" },
  { name = "path" },
  { name = "luasnip" },
  { name = "cmp_tabnine" },
  { name = "nvim_lua" },
  { name = "buffer" },
  { name = "calc" },
  { name = "emoji" },
  { name = "treesitter" },
  { name = "crates" },
  { name = "tmux" },
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
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

-- Evil Lualine
local colors = require "lvim.core.lualine.colors"
local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}
lvim.builtin.lualine.options = {
  component_separators = '',
  section_separators = '',
  theme = {
    normal = { c = { fg = colors.fg, bg = colors.bg } },
    inactive = { c = { fg = colors.fg, bg = colors.bg } },
  },
}
lvim.builtin.lualine.sections = {
  lualine_a = {},
  lualine_b = {},
  lualine_y = {},
  lualine_z = {},
  lualine_c = {},
  lualine_x = {},
}
lvim.builtin.lualine.inactive_sections = {
  lualine_a = {},
  lualine_b = {},
  lualine_y = {},
  lualine_z = {},
  lualine_c = {},
  lualine_x = {},
}

local function ins_left(component)
  table.insert(lvim.builtin.lualine.sections.lualine_c, component)
end

local function ins_right(component)
  table.insert(lvim.builtin.lualine.sections.lualine_x, component)
end

local function mode_color()
  local color = {
    n = colors.red,
    i = colors.green,
    v = colors.magenta,
    [''] = colors.magenta,
    V = colors.magenta,
    c = colors.blue,
    no = colors.red,
    s = colors.orange,
    S = colors.orange,
    [''] = colors.orange,
    ic = colors.yellow,
    R = colors.violet,
    Rv = colors.violet,
    cv = colors.red,
    ce = colors.red,
    r = colors.cyan,
    rm = colors.cyan,
    ['r?'] = colors.cyan,
    ['!'] = colors.red,
    t = colors.red,
  }
  return { fg = color[vim.fn.mode()] }
end

ins_left {
  function()
    return '▊'
  end,
  color = function ()
    return mode_color()
  end,
  padding = { right = 1 },
}

ins_left {
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' LSP:',
  color = { fg = colors.white, gui = 'bold' },
}

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}

ins_left {
  function()
    return '%='
  end,
}

ins_left {
  'filename',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = 'bold' },
}

ins_left {
  function()
    local current_line = vim.fn.line "."
    local total_lines = vim.fn.line "$"
    local chars = { "", "", "", "", "", "", "", "", "", "", "", "", "" }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
  end,
  color = { fg = colors.yellow, gui = 'bold' }
}

ins_left {
  '%04l:%04c',
}

ins_right {
  'o:encoding',
  fmt = string.upper,
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'fileformat',
  fmt = string.upper,
  icons_enabled = false,
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
}

ins_right {
  'diff',
  symbols = { added = ' ', modified = '柳 ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

ins_right {
  function()
    return '▊'
  end,
  color = function ()
    return mode_color()
  end,
  padding = { left = 1 },
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
  { "sindrets/diffview.nvim",
    event = "BufRead",
  },
  { "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup {}
    end,
  },
  { "felipec/vim-sanegx",
    event = "BufRead",
  },
  { "ptzz/lf.vim",
    requires = "voldikss/vim-floaterm",
  },
  { "vimwiki/vimwiki" },
  { "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ '*' }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  { "fladson/vim-kitty" },
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "svermeulen/vim-easyclip" },
}

-- Functions for keymappings
function Custom_Close()
  local num_bufs = #vim.tbl_filter(
    function(buf)
      return vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_option(buf, 'buflisted')
    end,
    vim.api.nvim_list_bufs()
  )
  if num_bufs <= 1 then
    vim.cmd("quit")
  end
  vim.api.nvim_buf_delete(0, {})
end

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.insert_mode = {
  ["<C-S>"] = "<ESC>:w<CR>a",
  ["<C-Q>"] = "<ESC>:lua Custom_Close()<CR>",
  ["<C-BS>"] = "<C-W>",
}
lvim.keys.normal_mode = {
  ["<c-s>"] = ":w<CR>",
  ["<c-q>"] = ":lua Custom_Close()<CR>",
}
lvim.keys.term_mode = {
}
lvim.keys.visual_mode = {
  ["<c-s>"] = "<ESC>:w<CR>",
  ["<c-q>"] = "<ESC>:lua Custom_Close()<CR>",
  ["<"] = "<gv",
  [">"] = ">gv",
}
lvim.keys.visual_block_mode = {
  ["<c-s>"] = "<ESC>:w<CR>",
  ["<c-q>"] = "<ESC>:lua Custom_Close()<CR>",
  ["K"] = ":move '<-2<CR>gv-gv",
  ["J"] = ":move '>+1<CR>gv-gv",
}

lvim.builtin.which_key.mappings = {
  [";"] = { "<cmd>Alpha<CR>", "Dashboard" },
  ["/"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Comment" },
  ["f"] = { require("lvim.core.telescope.custom-finders").find_project_files, "Find File" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["e"] = { "<cmd>Lf<CR>", "List Files" },
  b = {
    name = "Buffers",
    j = { "<cmd>BufferLinePick<cr>", "Jump" },
    f = { "<cmd>Telescope buffers<cr>", "Find" },
    b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
    c = { "<cmd>w!<CR><cmd>!compiler \"%:p\"<CR>", "Compile" },
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
  p = {
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
  w = { name = "VimWiki" },
  z = { name = "Folding" }
}
