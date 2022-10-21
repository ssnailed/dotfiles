local status_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not status_ok then
  return
end

local serverlist = require('config.lsp')
local servers = {}
for key,_ in pairs(serverlist) do
  table.insert(servers, key)
end

mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = false,
})
