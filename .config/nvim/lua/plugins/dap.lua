local dap_status_ok, dap = pcall(require, 'dap')
if not dap_status_ok then
    return
end
local dap_ui_status_ok, dapui = pcall(require, 'dapui')
if not dap_ui_status_ok then
    return
end

local icons = require('config.icons').list

vim.fn.sign_define("DapBreakpoint", { text = icons.ui.Bug, texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
