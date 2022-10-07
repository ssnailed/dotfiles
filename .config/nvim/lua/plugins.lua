local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)
  -- General Functionality
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'windwp/nvim-autopairs'
  use 'numToStr/Comment.nvim'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use 'akinsho/bufferline.nvim'
  use 'moll/vim-bbye'
  use 'nvim-lualine/lualine.nvim'
  use 'akinsho/toggleterm.nvim'
  use 'ahmedkhalf/project.nvim'
  use 'lewis6991/impatient.nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'goolord/alpha-nvim'
  use 'RRethy/vim-illuminate'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'lewis6991/gitsigns.nvim'
  -- Color Schemes
  use 'folke/tokyonight.nvim'
  -- Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
-- Snippets
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'
-- LSP/DAP
  use 'williamboman/mason.nvim'
  use 'mfussenegger/nvim-dap'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason-lspconfig.nvim'



  use 'fladson/vim-kitty'
  use 'folke/lua-dev.nvim'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'norcalli/nvim-colorizer.lua'
  use 'vimwiki/vimwiki'
  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup()
      require('keybinds').wk_setup()
    end
  }
  use {
  }
  use {
    'felipec/vim-sanegx',
    event = 'BufRead',
  }
  use {
    'sindrets/diffview.nvim',
    event = 'BufRead'
  }
  use {
  }
  if packer_bootstrap then
    require('packer').sync()
  end
end)
