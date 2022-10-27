local icons = require "config.iconlist"
local plugins = {
  { "wbthomason/packer.nvim",
    config = function()
      require('funcs').map("packer")
    end
  },
  { "nvim-lua/plenary.nvim" },
  { "lewis6991/impatient.nvim" },
  { "tpope/vim-surround",
    setup = function()
      require('funcs').on_file_open("vim-surround")
    end
  },
  { "tpope/vim-repeat",
    setup = function()
      require('funcs').on_file_open("vim-repeat")
    end
  },
  { "fladson/vim-kitty",
    ft = "kitty"
  },
  { "kyazdani42/nvim-web-devicons" },
  { "felipec/vim-sanegx",
    setup = function()
      require('funcs').on_file_open("vim-sanegx")
    end
  },
  { "folke/which-key.nvim",
    config = function()
      require('plugins.config.whichkey')
    end,
  },
  { "folke/tokyonight.nvim",
    config = function()
      require('plugins.config.tokyonight')
    end
  },
  { "folke/todo-comments.nvim",
    setup = function()
      require('funcs').on_file_open("todo-comments.nvim")
    end,
    config = function()
      require('plugins.config.todo-comments')
    end
  },
  { "akinsho/bufferline.nvim",

    setup = function()
      require('funcs').on_file_open("bufferline.nvim")
    end,
    config = function()
      require('funcs').map("bufferline")
      require('plugins.config.bufferline')
    end,
  },
  { "nvim-lualine/lualine.nvim",
    setup = function()
      require('funcs').on_file_open("lualine.nvim")
    end,
    config = function()
      require('plugins.config.lualine')
    end,
  },
  { "akinsho/toggleterm.nvim",
    config = function()
      require('plugins.config.toggleterm')
    end,
  },
  { "lukas-reineke/indent-blankline.nvim",
    after = "nvim-treesitter",
    setup = function()
      require('funcs').on_file_open("indent-blankline.nvim")
    end,
    config = function()
      require('funcs').map("blankline")
      require('plugins.config.indent-blankline')
    end,
  },
  { "norcalli/nvim-colorizer.lua",
    setup = function()
      require('funcs').on_file_open("nvim-colorizer.lua")
    end,
    config = function()
      require('plugins.config.nvim-colorizer')
    end,
  },
  { "RRethy/vim-illuminate",
    setup = function()
      require('funcs').on_file_open("vim-illuminate")
    end,
    config = function()
      require('funcs').map("illuminate")
      require('plugins.config.illuminate')
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
      require('plugins.config.treesitter')
    end,
  },
  { "lewis6991/gitsigns.nvim",
    ft = "gitcommit",
    setup = function()
      require('funcs').gitsigns()
    end,
    config = function()
      require('plugins.config.gitsigns')
    end,
  },
  { "williamboman/mason.nvim",
    setup = function()
      require('funcs').map("mason")
    end,
    config = function()
      require "plugins.config.mason"
    end,
  },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig",
    after = "mason-lspconfig.nvim",
    setup = function()
      require('funcs').on_file_open("nvim-lspconfig")
    end,
    config = function()
      require('funcs').map("lspconfig")
      require('plugins.config.lspconfig')
    end,
  },
  { "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require('plugins.config.null-ls')
    end,
  },
  { "rcarriga/nvim-dap-ui",
    after = "nvim-dap",
    setup = function()
      require('funcs').on_file_open("nvim-dap-ui")
    end,
    config = function()
      require('plugins.config.dapui')
    end,
  },
  { "mfussenegger/nvim-dap",
    setup = function()
      require('funcs').on_file_open("nvim-dap")
    end,
    config = function()
      require('funcs').map("dap")
      require('plugins.config.dap')
    end,
  },
  { "rafamadriz/friendly-snippets",
    event = "InsertEnter",
    module = { "cmp", "cmp_nvim_lsp" },
  },
  { "hrsh7th/nvim-cmp",
    after = "friendly-snippets",
    config = function()
      require('plugins.config.cmp')
    end,
  },
  { "L3MON4D3/LuaSnip",
    after = "nvim-cmp",
    config = function()
      require('plugins.config.luasnip')
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
      require('plugins.config.autopairs')
    end,
  },
  { "goolord/alpha-nvim",
    config = function()
      require('plugins.config.alpha')
    end,
  },
  { "numToStr/Comment.nvim",
    setup = function()
      require('funcs').on_file_open("Comment.nvim")
    end,
    config = function()
      require('funcs').map("comment")
      require('plugins.config.comment')
    end,
  },
  { "kyazdani42/nvim-tree.lua",
    ft = "alpha",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require('funcs').map("nvimtree")
      require('plugins.config.nvim-tree')
    end,
  },
  { "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function()
      require('funcs').map("telescope")
      require('plugins.config.telescope')
    end,
  },
  { "ahmedkhalf/project.nvim",
    cmd = "Telescope",
    after = "telescope.nvim",
    config = function()
      require('plugins.config.project')
    end,
  },
}

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end
vim.cmd "packadd packer.nvim"
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
      return require('packer.util').float { border = "single" }
    end
  }
}
packer.startup { plugins }
