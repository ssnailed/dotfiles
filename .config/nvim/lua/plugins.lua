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
  use 'vimwiki/vimwiki'
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-lualine/lualine.nvim'
  -- setup handled in lualine-conf.lua
  use {
    'akinsho/bufferline.nvim',
    config = function()
      require('bufferline').setup()
    end
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup()
    end
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
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  }
  use {
    'williamboman/mason-lspconfig.nvim',
    requires = 'neovim/nvim-lspconfig'
  }
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup({'*'}, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  }
  use {
    'folke/tokyonight.nvim',
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = true,
      })
    end,
  }
  if packer_bootstrap then
    require('packer').sync()
  end
end)
