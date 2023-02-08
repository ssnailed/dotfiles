local o = vim.opt
local g = vim.g

o.undodir        = vim.fn.stdpath "cache" .. "/undo"
o.clipboard      = "unnamedplus"
o.conceallevel   = 0
o.numberwidth    = 3
o.hlsearch       = true
o.ignorecase     = true
o.showmode       = false
o.smartindent    = true
o.splitbelow     = true
o.splitbelow     = true
o.splitbelow     = true
o.updatetime     = 250
o.writebackup    = false
o.expandtab      = true
o.shiftwidth     = 4
o.tabstop        = 4
o.cursorline     = true
o.signcolumn     = "yes"
o.wrap           = false
o.scrolloff      = 8
o.sidescrolloff  = 8
o.undofile       = true
o.title          = true
o.titlestring    = " %t"
o.termguicolors  = true
o.timeoutlen     = 500
o.foldmethod     = "expr"
o.foldlevelstart = 99
o.foldexpr       = "nvim_treesitter#foldexpr()"
o.number         = true
o.relativenumber = true
o.laststatus     = 3
o.modeline       = true
o.modelines      = 3
o.listchars      = "eol:$,tab:>-,trail:~,extends:>,precedes:<"

g.Illuminate_ftblacklist = { 'alpha', 'NvimTree' }
g.mapleader = ' '

local icons = require 'config.iconlist'

local signs = {
    DiagnosticSignError = icons.BoldError,
    DiagnosticSignWarn = icons.BoldWarning,
    DiagnosticSignHint = icons.BoldHint,
    DiagnosticSignInfo = icons.BoldInformation
}

for type, icon in pairs(signs) do
    local hl = type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
