local status_ok, todo_comments = pcall(require, 'todo-comments')
if not status_ok then
    return
end

todo_comments.setup({
    highlight = {
        multiline = false,
        comments_only = false
    }
})
