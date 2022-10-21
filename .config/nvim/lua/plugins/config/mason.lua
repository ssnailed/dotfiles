local status_ok, mason = pcall(require, 'mason')
if not status_ok then
  return
end

local serverlist = require('config.lsp')
local servers = {}
for key,_ in pairs(serverlist) do
  table.insert(servers, key)
end
local icons = require('config.iconlist')

local settings = {
  ui = {
    border = "none",
    icons = {
      package_installed = icons.ui.Check,
      package_pending = icons.ui.BoldArrowRight,
      package_uninstalled = icons.ui.BoldClose,
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)
