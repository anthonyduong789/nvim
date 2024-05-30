## Example of creatgin virtual Tesk on enter of a buffer

    -- Create or open the file buffer
    local buf = vim.fn.bufadd(file_path)

    -- local buf = vim.api.nvim_get_current_buf() -- Get the current buffer handle
    local ns_id = vim.api.nvim_create_namespace("MyPlugin") -- Create a new namespace
    local line = 0 -- Line number where the text should be added
    local chunks = { { "Hello, world!", "Error" } } -- Text chunks with their associated highlight groups

    vim.api.nvim_buf_set_virtual_text(buf, ns_id, line, chunks, {})
