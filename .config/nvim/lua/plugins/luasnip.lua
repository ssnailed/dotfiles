local status_ok, luasnip = pcall(require, "LuaSnip")
if not status_ok then
    return
end

luasnip.setup({
    history = true,
})

vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
        if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require("luasnip").session.jump_active
        then
            require("luasnip").unlink_current()
        end
    end,
})
