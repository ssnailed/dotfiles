vim.defer_fn(function()
  pcall(require, "impatient")
end, 0)

require('config.options')
require('funcs').bootstrap()
require('plugins')
require('funcs').autocmd(require('config.autocmdlist'))
require('funcs').map('general')

local icons = require('config.iconlist').diagnostics
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
