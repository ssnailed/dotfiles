local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
    return
end

local colors = require('tokyonight.colors').setup({ transform = true })
local icons = require('config.icons').list

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

local config = {
    options = {
        component_separators = '',
        section_separators = '',
        -- theme = {
        --   normal = { c = { fg = colors.fg, bg = colors.bg } },
        --   inactive = { c = { fg = colors.fg, bg = colors.bg } },
        -- },
        disabled_filetypes = {
            statusline = { 'alpha' }
        },
        ignore_focus = { 'toggleterm', 'NvimTree' },
        globalstatus = true,
    },
    sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    }
}

local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end

local function mode_color()
    local color = {
        n = colors.red,
        i = colors.green,
        v = colors.magenta,
        [''] = colors.magenta,
        V = colors.magenta,
        c = colors.blue,
        no = colors.red,
        s = colors.orange,
        S = colors.orange,
        [''] = colors.orange,
        ic = colors.yellow,
        R = colors.violet,
        Rv = colors.violet,
        cv = colors.red,
        ce = colors.red,
        r = colors.cyan,
        rm = colors.cyan,
        ['r?'] = colors.cyan,
        ['!'] = colors.red,
        t = colors.red,
    }
    return { fg = color[vim.fn.mode()] }
end

ins_left {
    function()
        return '▊'
    end,
    color = function()
        return mode_color()
    end,
    padding = { right = 1 },
}

ins_left {
    function()
        local msg = 'None Active'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                if client.name ~= "null-ls" then
                    return client.name
                end
                msg = client.name
            end
        end
        return msg
    end,
    icon = ' LSP:',
    color = { fg = colors.white },
}

ins_left {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = { error = icons.diagnostics.BoldError .. ' ', warn = icons.diagnostics.BoldWarning .. ' ',
        info = icons.diagnostics.BoldInformation },
    diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
    },
}

ins_left {
    function()
        return '%='
    end,
}

ins_left {
    'filename',
    color = { fg = colors.magenta, gui = 'bold' },
}

ins_left {
    function()
        local current_line = vim.fn.line "."
        local total_lines = vim.fn.line "$"
        local chars = icons.progress
        local line_ratio = current_line / total_lines
        local index = math.ceil(line_ratio * #chars)
        return chars[index]
    end,
    color = { fg = colors.yellow }
}

ins_left {
    '%04l:%04c',
}

ins_right {
    'o:encoding',
    fmt = string.upper,
    cond = conditions.hide_in_width,
    color = { fg = colors.green, gui = 'bold' },
}

ins_right {
    'fileformat',
    fmt = string.upper,
    icons_enabled = false,
    color = { fg = colors.green, gui = 'bold' },
}

ins_right {
    'branch',
    icon = icons.git.Branch,
    color = { fg = colors.violet, gui = 'bold' },
}

ins_right {
    'diff',
    symbols = { added = ' ', modified = '柳', removed = ' ' },
    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
    },
    cond = conditions.hide_in_width,
}

ins_right {
    function()
        return '▊'
    end,
    color = function()
        return mode_color()
    end,
    padding = { left = 1 },
}

lualine.setup(config)
