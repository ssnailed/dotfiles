local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "user.adapters.mason"
require("user.adapters.handlers").setup()
require "user.adapters.null-ls"
require "user.adapters.dap"
