local M = {}
M.list = {
    {
        extension = {
            yml = function(path, bufnr)
                if vim.fs.find({ 'tasks', 'roles', 'handlers', 'group_vars', 'host_vars' },
                    { type = 'directory', upward = true }) and
                    vim.fs.find({ 'ansible.cfg', '.ansible-lint' }, { upward = true }) then
                    return 'yaml.ansible'
                else
                    return 'yaml'
                end
            end,
            yaml = function(path, bufnr)
                if vim.fs.find({ 'tasks', 'roles', 'handlers', 'group_vars', 'host_vars' },
                    { type = 'directory', upward = true }) and
                    vim.fs.find({ 'ansible.cfg', '.ansible-lint' }, { upward = true }) then
                    return 'yaml.ansible'
                else
                    return 'yaml'
                end
            end
        }
    }
}

M.setup = function()
    for _, entry in pairs(M.list) do
        vim.filetype.add(entry)
    end
end

return M
