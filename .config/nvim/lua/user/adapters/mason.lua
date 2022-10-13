local servers = {
  "sumneko_lua",
  "bashls",
  "clangd",
}

local icons = require('iconlist')

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

require("mason").setup(settings)
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.adapters.handlers").on_attach,
    capabilities = require("user.adapters.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  local require_ok, conf_opts = pcall(require, "user.adapters.settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  lspconfig[server].setup(opts)
end
