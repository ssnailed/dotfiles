require('plugins')
require('keybinds')

require('bufferline').setup() -- TODO: only open when more than one buffer is open, remove exit button
require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require("mason-lspconfig").setup({
    ensure_installed = { "sumneko_lua", "bashls", "clangd" },
    automatic_installation = false
})
require('tokyonight').setup({
  transparent = true,
  terminal_colors = true,
  dim_inactive = true,
  lualine_bold = true,
})

vim.cmd[[colorscheme tokyonight]]
vim.opt.undodir        = vim.fn.stdpath "cache" .. "/undo"
vim.opt.clipboard      = "unnamedplus"
vim.opt.conceallevel   = 0
vim.opt.numberwidth    = 3
vim.opt.hlsearch       = true
vim.opt.ignorecase     = true
vim.opt.showmode       = false
vim.opt.smartindent    = true
vim.opt.splitbelow     = true
vim.opt.splitbelow     = true
vim.opt.splitbelow     = true
vim.opt.updatetime     = 300
vim.opt.writebackup    = false
vim.opt.expandtab      = true
vim.opt.shiftwidth     = 2
vim.opt.tabstop        = 2
vim.opt.cursorline     = true
vim.opt.signcolumn     = "yes"
vim.opt.wrap           = false
vim.opt.scrolloff      = 8
vim.opt.sidescrolloff  = 8
vim.opt.undofile       = true
vim.opt.title          = true
vim.opt.titlestring    = " %t"
vim.opt.termguicolors  = true
vim.opt.timeoutlen     = 500
vim.opt.foldmethod     = "expr"
vim.opt.foldlevelstart = 99
vim.opt.foldexpr       = "nvim_treesitter#foldexpr()"
vim.opt.number         = true
vim.opt.relativenumber = true

-- set autocmds defined in autocmd.lua
for _, entry in ipairs(require('autocmds')) do
  local event = entry[1]
  local opts = entry[2]
  if type(opts.group) == "string" and opts.group ~= "" then
    local exists, _ = pcall(vim.api.nvim_get_autocmds, { group = opts.group })
    if not exists then
      vim.api.nvim_create_augroup(opts.group, {})
    end
  end
  vim.api.nvim_create_autocmd(event, opts)
end

-- automatically set up language servers
-- local lspconfig = require('lspconfig')
-- local mason_registry = require('mason-registry')
-- lspconfig.util.default_config = vim.tbl_extend(
--     "force",
--     lspconfig.util.default_config,
--     {
--         on_attach = on_attach
--     }
-- )
-- for _, server in ipairs(require('mason-registry').get_installed_packages()) do
--   lspconfig[server.name].setup {}
-- end
