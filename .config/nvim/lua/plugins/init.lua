local packer_bootstrap = require('funcs').bootstrap()
local icons = require "config.iconlist"
local plugins = {
  { "wbthomason/packer.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "lewis6991/impatient.nvim" },
  { "tpope/vim-surround",
    setup = function()
      require('funcs').on_file_open("vim-surround")
    end,
  },
  { "tpope/vim-repeat",
    setup = function()
      require('funcs').on_file_open("vim-repeat")
    end,
  },
  { "fladson/vim-kitty",
    ft = "kitty"
  },
  { "kyazdani42/nvim-web-devicons" },
  { "felipec/vim-sanegx" },
  { "folke/which-key.nvim",
    config = function()
      require "plugins.config.whichkey"
    end,
  },
  { "folke/tokyonight.nvim",
    config = function()
      require('plugins.config.tokyonight')
    end
  },
  { "folke/todo-comments.nvim",
    opt = true,
    after = "which-key.nvim",
    setup = function()
      require('funcs').on_file_open("todo-comments.nvim")
      require('funcs').map("todo")
    end,
    config = function()
      require('plugins.config.todo-comments')
    end
  },
  { "akinsho/bufferline.nvim",
    opt = true,
    after = "which-key.nvim",
    setup = function()
      require('funcs').on_file_open("bufferline.nvim")
      require('funcs').map("bufferline")
    end,
    config = function()
      require("plugins.config.bufferline")
    end,
  },
  { "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.config.lualine")
    end,
  },
  { "akinsho/toggleterm.nvim",
    config = function()
      require("plugins.config.toggleterm")
    end,
  },
  { "lukas-reineke/indent-blankline.nvim",
    opt = true,
    after = "which-key.nvim",
    setup = function()
      require('funcs').on_file_open("indent-blankline.nvim")
      require('funcs').map("blankline")
    end,
    config = function()
      require("plugins.config.indent-blankline")
    end,
  },
  { "norcalli/nvim-colorizer.lua",
    opt = true,
    setup = function()
      require('funcs').on_file_open("nvim-colorizer.lua")
    end,
    config = function()
      require("plugins.config.nvim-colorizer")
    end,
  },
  { "RRethy/vim-illuminate",
    opt = true,
    setup = function()
      require('funcs').on_file_open("vim-illuminate")
      require('funcs').map("illuminate")
    end,
    config = function()
      require("plugins.config.illuminate")
    end,
  },
  { "nvim-treesitter/nvim-treesitter",
    setup = function()
      require('funcs').on_file_open("nvim-treesitter")
    end,
    cmd = {
      "TSInstall",
      "TSBufEnable",
      "TSBufDisable",
      "TSEnable",
      "TSDisable",
      "TSModuleInfo"
    },
    run = ":TSUpdate",
    config = function()
      require("plugins.config.treesitter")
    end,
  },
  { "lewis6991/gitsigns.nvim",
    ft = "gitcommit",
    setup = function()
      require('funcs').gitsigns()
    end,
    config = function()
      require("plugins.config.gitsigns")
    end,
  },
  { "williamboman/mason.nvim",
    config = function()
      require "plugins.config.mason"
    end,
  },
  { "williamboman/mason-lspconfig.nvim",
    config = function()
      require("plugins.config.mason-lspconfig")
    end,
  },
  { "neovim/nvim-lspconfig",
    setup = function()
      require('funcs').on_file_open("nvim-lspconfig")
    end,
    config = function()
      require("plugins.config.lspconfig")
    end,
  },
  { "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("plugins.config.null-ls")
    end,
  },
  { "rcarriga/nvim-dap-ui",
    opt = true,
    after = "nvim-dap",
    setup = function()
      require('funcs').on_file_open("nvim-dap-ui")
    end,
    config = function()
      require("plugins.config.dapui")
    end,
  },
  { "mfussenegger/nvim-dap",
    opt = true,
    setup = function()
      require('funcs').on_file_open("nvim-dap")
    end,
    config = function()
      require("plugins.config.dap")
    end,
  },
  { "rafamadriz/friendly-snippets",
    module = { "cmp", "cmp_nvim_lsp" },
  },
  { "hrsh7th/nvim-cmp",
    after = "friendly-snippets",
    config = function()
      require("plugins.config.cmp")
    end,
  },
  { "L3MON4D3/LuaSnip",
    after = "nvim-cmp",
    config = function()
      require("plugins.config.luasnip")
    end,
  },
  { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
  { "hrsh7th/cmp-nvim-lua", after = "cmp_luasnip" },
  { "hrsh7th/cmp-nvim-lsp", after = "cmp-nvim-lua" },
  { "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" },
  { "hrsh7th/cmp-path", after = "cmp-buffer" },
  { "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require("plugins.config.autopairs")
    end,
  },
  { "goolord/alpha-nvim",
    config = function()
      require("plugins.config.alpha")
    end,
  },
  { "numToStr/Comment.nvim",
    module = "Comment",
    after = "which-key.nvim",
    keys = { "gc", "gb" },
    config = function()
      require("plugins.config.comment")
    end,
    setup = function()
      require('funcs').map("comment")
    end,
  },
  { "kyazdani42/nvim-tree.lua",
    ft = "alpha",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    after = "which-key.nvim",
    config = function()
      require("plugins.config.nvim-tree")
    end,
    setup = function()
      require('funcs').map("nvimtree")
    end,
  },
  { "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    after = "which-key.nvim",
    config = function()
      require("plugins.config.telescope")
    end,
   setup = function()
     require('funcs').map("telescope")
   end,
  },
  { "ahmedkhalf/project.nvim",
    ft = "alpha",
    cmd = "lua require('telescope').extensions.projects.projects()<CR>",
    after = "telescope.nvim",
    config = function()
      require("plugins.config.project")
    end,
  },
}

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end
vim.cmd("packadd packer.nvim")
packer.init {
  auto_clean = true,
  compile_on_sync = true,
  git = { clone_timeout = 6000 },
  display = {
    working_sym = icons.misc.Watch,
    error_sym = icons.ui.Close,
    done_sym = icons.ui.Check,
    removed_sym = icons.ui.MinusCircle,
    moved_sym = icons.ui.Forward,
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end
  }
}
packer.startup { plugins }
if packer_bootstrap then
  require('packer').sync()
end
