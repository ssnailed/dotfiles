local status_ok, alpha = pcall(require, 'alpha')
if not status_ok then
    return
end

local dashboard = require('alpha.themes.dashboard')
local icons = require('config.icons').list

local banner = {
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣶⣿⣿⣿⣷⣶⣤⡀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀",
    "⠀⣀⣴⣶⣶⣶⣶⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀",
    "⣰⣿⣿⠿⠛⠿⢿⣿⣿⣷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀",
    "⣿⣿⡇⠀⠀⠀⠀⠈⠛⢿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀",
    "⠹⣿⣧⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿⣦⣄⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣿⣿⣿⡿⠛⠉⠀⢀⣿⣿⣿⣿⣿⣿⣿⠟⠀⠀⠀⠀⠀",
    "⠀⠙⢿⣧⡀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿⣿⣷⣶⣶⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣷⣤⣤⣶⣿⣿⣿⣿⣿⡿⠟⠁⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠉⠻⠷⡄⠀⠀⠀⠀⠀⠀⠀⠈⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠉⠀⢀⣠⣤⣤⣄⡀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠋⠁⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣷⡀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣄⡀⠀⠀⠀⠀⣿⠟⠉⠉⠙⢿⣿⣿⣷",
    "⠀⠀⠀⣀⣠⣤⣤⣤⣶⣶⣶⣤⣤⠀⣴⣿⣿⣿⡿⠟⠛⠛⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠉⠀⠀⠀⢀⣼⣿⣿⡿",
    "⠀⠀⠀⠈⠉⠉⠉⠉⠉⠉⠛⠻⠏⣼⣿⣿⡿⣋⣀⣤⣤⣴⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⣄⣀⣠⣴⣾⣿⣿⡿⠁",
    "⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⡿⠋⠘⠿⠟⠛⠛⢻⣿⣿⣿⠋⠁⠈⠉⢿⣿⣿⣧⠀⠙⠻⢿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠉⠀⠀",
    "⠙⣷⣤⣀⠀⠀⠀⢀⣀⣤⣶⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⡟⠀⠀⠀⢠⣿⣿⣿⡟⠀⠀⠀⠀⠀⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀",
    "⠀⠈⠛⠿⢿⣿⣿⣿⠿⠿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⡀⠀⢠⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⣿⣷⣶⣶⣶⣶⣦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣙⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⢶⣦⣤⣶⣾⣿⣿⡶⠈⠉⠛⠿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣤⣶⡿⠿⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
}

if vim.o.lines < 36 then
    banner = vim.list_slice(banner, 16, 22)
end

dashboard.section.header.val = banner

dashboard.section.buttons.val = {
    dashboard.button("n", icons.ui.NewFile .. " New file", "<CMD>ene<CR>"),
    dashboard.button("e", icons.ui.FindFile .. " Open file", "<CMD>Lf<CR>"),
    dashboard.button("q", icons.ui.SignOut .. " Quit", "<CMD>qa<CR>"),
}

dashboard.section.footer.val = "Behold: a Snail's Vim"

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

-- dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
