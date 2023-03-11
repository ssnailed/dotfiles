local icons = require('config.icons').list
local plugins = {
    { "wbthomason/packer.nvim",
        config = function()
            require('config.keymaps').map("packer")
        end
    },
    { "nvim-lua/plenary.nvim" },
    { "lewis6991/impatient.nvim" },
    { "kylechui/nvim-surround",
        config = function()
            require('plugins.nvim-surround')
        end
    },
    { "fladson/vim-kitty",
        ft = "kitty"
    },
    { "kyazdani42/nvim-web-devicons" },
    { "felipec/vim-sanegx",
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
    },
    { "folke/which-key.nvim",
        config = function()
            require('plugins.whichkey')
        end,
    },
    { "folke/tokyonight.nvim",
        config = function()
            require('plugins.tokyonight')
        end
    },
    { "folke/todo-comments.nvim",
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function()
            require('plugins.todo-comments')
        end
    },
    { "akinsho/bufferline.nvim",
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function()
            require('plugins.bufferline')
            require('config.keymaps').map("bufferline")
        end,
    },
    { "nvim-lualine/lualine.nvim",
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function()
            require('plugins.lualine')
        end,
    },
    { "akinsho/toggleterm.nvim",
        config = function()
            require('plugins.toggleterm')
        end,
    },
    { "lukas-reineke/indent-blankline.nvim",
        after = "nvim-treesitter",
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function()
            require('plugins.indent-blankline')
            require('config.keymaps').map("blankline")
        end,
    },
    { "norcalli/nvim-colorizer.lua",
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function()
            require('plugins.nvim-colorizer')
        end,
    },
    { "RRethy/vim-illuminate",
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function()
            require('plugins.illuminate')
            require('config.keymaps').map("illuminate")
        end,
    },
    { "nvim-treesitter/nvim-treesitter",
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
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
            require('plugins.treesitter')
        end,
    },
    { "lewis6991/gitsigns.nvim",
        ft = "gitcommit",
        setup = function()
            vim.api.nvim_create_autocmd({ "BufRead" }, {
                group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
                callback = function()
                    vim.fn.system("git rev-parse " .. vim.fn.expand "%:p:h")
                    if vim.v.shell_error == 0 then
                        vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
                        vim.schedule(function()
                            require("packer").loader "gitsigns.nvim"
                        end)
                    end
                end,
            })
        end,
        config = function()
            require('plugins.gitsigns')
        end,
    },
    { "williamboman/mason.nvim",
        setup = function()
            require('config.keymaps').map("mason")
        end,
        config = function()
            require "plugins.mason"
        end,
    },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig",
        after = "mason-lspconfig.nvim",
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function()
            require('plugins.lspconfig')
            require('config.keymaps').map("lspconfig")
        end,
    },
    { "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require('plugins.null-ls')
        end,
    },
    { "rcarriga/nvim-dap-ui",
        after = "nvim-dap",
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function()
            require('plugins.dapui')
        end,
    },
    { "mfussenegger/nvim-dap",
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function()
            require('plugins.dap')
            require('config.keymaps').map("dap")
        end,
    },
    { "hrsh7th/nvim-cmp",
        config = function()
            require('plugins.cmp')
        end,
    },
    { "L3MON4D3/LuaSnip",
        after = "nvim-cmp",
        run = "make install_jsregexp",
        config = function()
            require('plugins.luasnip')
        end,
    },
    { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
    { "hrsh7th/cmp-nvim-lua",     after = "cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lsp",     after = "cmp-nvim-lua" },
    { "hrsh7th/cmp-buffer",       after = "cmp-nvim-lsp" },
    { "hrsh7th/cmp-path",         after = "cmp-buffer" },
    { "onsails/lspkind.nvim" },
    { "windwp/nvim-autopairs",
        after = "nvim-cmp",
        event = "InsertEnter",
        config = function()
            require('plugins.autopairs')
        end,
    },
    { "goolord/alpha-nvim",
        config = function()
            require('plugins.alpha')
        end,
    },
    { "numToStr/Comment.nvim",
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function()
            require('plugins.comment')
            require('config.keymaps').map("comment")
        end,
    },
    { "lmburns/lf.nvim",
        commit = "383429497292dd8a84271e74a81c6db6993ca7ab",
        config = function()
            require('plugins.lf')
            require('config.keymaps').map("lf")
        end
    },
}

local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end
vim.cmd "packadd packer.nvim"
packer.init {
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
