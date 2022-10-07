require('plugins')
require('keybinds')
require('options')

require('bufferline').setup({
  options = {
    show_buffer_close_icons = false,
    show_close_icon = false,
    always_show_bufferline = false,
  }
})
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
