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
  use 'williamboman/mason.nvim'
  use { 'williamboman/mason-lspconfig.nvim',
    requires = 'neovim/nvim-lspconfig'
  }

  use 'fladson/vim-kitty'
  use 'folke/lua-dev.nvim'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use { 'folke/tokyonight.nvim',
    config = function()
      require("tokyonight").setup({
        transparent = true, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        dim_inactive = true, -- dims inactive windows
        lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
      })
    end,
  }
  use 'vimwiki/vimwiki'
  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use { 'felipec/vim-sanegx',
    event = 'BufRead',
  }
  use { 'ptzz/lf.vim',
    requires = 'voldikss/vim-floaterm',
  }
  use { 'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
    event = 'BufRead'
  }
  use { 'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup({ '*' }, {
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
  if packer_bootstrap then
    require('packer').sync()
  end
end)
