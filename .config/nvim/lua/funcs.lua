local M = {}

function M.bootstrap()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e222a" })
        print "Cloning Packer..."
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd "packadd packer.nvim"
        require "plugins"
        vim.cmd "PackerSync"
        vim.api.nvim_create_autocmd("User", {
            pattern = "PackerComplete",
            callback = function()
                vim.cmd "bw | silent! MasonInstallAll" -- close packer window
                require("packer").loader "nvim-treesitter"
            end,
        })
    end
end

function M.format_filter(client)
    local filetype = vim.bo.filetype
    local n = require "null-ls"
    local s = require "null-ls.sources"
    local method = n.methods.FORMATTING
    local available_formatters = s.get_available(filetype, method)

    if #available_formatters > 0 then
        return client.name == "null-ls"
    elseif client.supports_method "textDocument/formatting" then
        return true
    else
        return false
    end
end

function M.format(opts)
    opts = opts or {}
    opts.filter = opts.filter or M.format_filter
    return vim.lsp.buf.format(opts)
end

-- Modified version of a function stolen from LunarVim
function M.buf_kill(kill_command, bufnr, force)
    kill_command = kill_command or "bd"

    local bo = vim.bo
    local api = vim.api
    local fmt = string.format
    local fnamemodify = vim.fn.fnamemodify

    if bufnr == 0 or bufnr == nil then
        bufnr = api.nvim_get_current_buf()
    end

    local bufname = api.nvim_buf_get_name(bufnr)

    if not force then
        local warning
        if bo[bufnr].modified then
            warning = fmt([[No write since last change for (%s)]], fnamemodify(bufname, ":t"))
        elseif api.nvim_buf_get_option(bufnr, "buftype") == "terminal" then
            warning = fmt([[Terminal %s will be killed]], bufname)
        end
        if warning then
            vim.ui.input({
                prompt = string.format([[%s. Close it anyway? [y]es or [n]o (default: no): ]], warning),
            }, function(choice)
                if choice:match "ye?s?" then force = true end
            end)
            if not force then return end
        end
    end

    -- Get list of windows IDs with the buffer to close
    local windows = vim.tbl_filter(function(win)
        return api.nvim_win_get_buf(win) == bufnr
    end, api.nvim_list_wins())

    if #windows == 0 then return end

    if force then
        kill_command = kill_command .. "!"
    end

    -- Get list of active buffers
    local buffers = vim.tbl_filter(function(buf)
        return api.nvim_buf_is_valid(buf) and bo[buf].buflisted
    end, api.nvim_list_bufs())

    -- If there is only one buffer (which has to be the current one), vim will
    -- create a new buffer on :bd.
    -- For more than one buffer, pick the previous buffer (wrapping around if necessary)
    if #buffers > 1 then
        for i, v in ipairs(buffers) do
            if v == bufnr then
                local prev_buf_idx = i == 1 and (#buffers - 1) or (i - 1)
                local prev_buffer = buffers[prev_buf_idx]
                for _, win in ipairs(windows) do
                    api.nvim_win_set_buf(win, prev_buffer)
                end
            end
        end
    else
        vim.cmd('q!')
    end

    -- Check if buffer still exists, to ensure the target buffer wasn't killed
    -- due to options like bufhidden=wipe.
    if api.nvim_buf_is_valid(bufnr) and bo[bufnr].buflisted then
        vim.cmd(string.format("%s %d", kill_command, bufnr))
    end
end

return M
