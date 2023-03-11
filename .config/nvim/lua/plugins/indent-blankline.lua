local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
    return
end

indent_blankline.setup {
    char = "▏",
    context_char = "▏",
    show_trailing_blankline_indent = false,
    show_first_indent_level = true,
    use_treesitter = true,
    show_current_context = false,
    show_end_of_line = false,
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = {
        "help",
        "packer",
        "NvimTree",
    },
}
