local status_ok, whichkey = pcall(require, 'which-key')
if not status_ok then
    return
end

local icons = require('config.icons').list

whichkey.setup({
    plugins = {
        marks = false,
        registers = false,
        presets = {
            operators = false,
            motions = false,
            text_objects = false,
            windows = false,
            nav = false,
            z = false,
            g = false,
        }
    },
    spelling = {
        enabled = false,
        suggestions = 20,
    },
    icons = {
        breadcrumb = icons.ui.DoubleChevronRight,
        separator = icons.ui.BoldArrowRight,
        group = icons.ui.Plus,
    },
    popup_mappings = {
        scroll_down = "<c-d>",
        scroll_up = "<c-u>",
    },
    window = {
        border = "single",
        position = "bottom",
        margin = { 1, 0, 1, 0 },
        padding = { 2, 2, 2, 2 },
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
    triggers = "auto",
    triggers_blacklist = {
        i = { "j", "k" },
        v = { "j", "k", "y" },
    },
})
