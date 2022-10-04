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

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'fladson/vim-kitty'
  use 'folke/lua-dev.nvim'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'norcalli/nvim-colorizer.lua'
  use 'folke/tokyonight.nvim'
  use 'vimwiki/vimwiki'
  use 'williamboman/mason.nvim'
  use 'kyazdani42/nvim-tree.lua'
  use 'mfussenegger/nvim-dap'
  use {
    'jose-elias-alvarez/null-ls.nvim'

  }
  use {
    'akinsho/bufferline.nvim',
    config = function ()
      require('bufferline').setup()
    end,
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup()
      require('keybinds').wk_setup()
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = 'nvim-lua/plenary.nvim'
  }
  use {
    'nvim-lualine/lualine.nvim',
    config = require('lualine-conf')
  }
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    'felipec/vim-sanegx',
    event = 'BufRead',
  }
  use {
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
    event = 'BufRead'
  }
  use {
    'williamboman/mason-lspconfig.nvim',
    requires = 'neovim/nvim-lspconfig'
  }
  if packer_bootstrap then
    require('packer').sync()
  end
end)
