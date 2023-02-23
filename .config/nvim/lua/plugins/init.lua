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
            require('plugins.config.nvim-surround')
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
            require('plugins.config.whichkey')
        end,
    },
    { "folke/tokyonight.nvim",
        config = function()
            require('plugins.config.tokyonight')
        end
    },
    { "folke/todo-comments.nvim",
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function()
            require('plugins.config.todo-comments')
        end
    },
    { "akinsho/bufferline.nvim",
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function()
            require('plugins.config.bufferline')
            require('config.keymaps').map("bufferline")
        end,
    },
    { "nvim-lualine/lualine.nvim",
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
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
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function()
            require('plugins.config.indent-blankline')
            require('config.keymaps').map("blankline")
        end,
    },
    { "norcalli/nvim-colorizer.lua",
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function()
            require('plugins.config.nvim-colorizer')
        end,
    },
    { "RRethy/vim-illuminate",
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function()
            require('plugins.config.illuminate')
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
            require('plugins.config.treesitter')
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
            require('plugins.config.gitsigns')
        end,
    },
    { "williamboman/mason.nvim",
        setup = function()
            require('config.keymaps').map("mason")
        end,
        config = function()
            require "plugins.config.mason"
        end,
    },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig",
        after = "mason-lspconfig.nvim",
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function()
            require('plugins.config.lspconfig')
            require('config.keymaps').map("lspconfig")
        end,
    },
    { "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require('plugins.config.null-ls')
        end,
    },
    { "rcarriga/nvim-dap-ui",
        after = "nvim-dap",
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function()
            require('plugins.config.dapui')
        end,
    },
    { "mfussenegger/nvim-dap",
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function()
            require('plugins.config.dap')
            require('config.keymaps').map("dap")
        end,
    },
    { "rafamadriz/friendly-snippets",
        event = "InsertEnter",
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
    { "hrsh7th/cmp-nvim-lua",     after = "cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lsp",     after = "cmp-nvim-lua" },
    { "hrsh7th/cmp-buffer",       after = "cmp-nvim-lsp" },
    { "hrsh7th/cmp-path",         after = "cmp-buffer" },
    { "onsails/lspkind.nvim" },
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
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function()
            require('plugins.config.comment')
            require('config.keymaps').map("comment")
        end,
    },
    { "nvim-telescope/telescope.nvim",
        config = function()
            require('plugins.config.telescope')
            require('config.keymaps').map("telescope")
        end,
    },
    { "ahmedkhalf/project.nvim",
        after = "telescope.nvim",
        config = function()
            require('plugins.config.project')
        end,
    },
    -- { "subnut/nvim-ghost.nvim",
    --     opt = true,
    --     run = ":call nvim_ghost#installer#install()",
    -- },
    { "lmburns/lf.nvim",
        opt = true,
        commit = "383429497292dd8a84271e74a81c6db6993ca7ab",
        config = function()
            require('plugins.config.lf')
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
