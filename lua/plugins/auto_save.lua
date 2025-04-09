local auto_save = {}

function auto_save.save()
    local buf = vim.api.nvim_get_current_buf()
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if buf_name ~= "" and not string.find(buf_name, "quickfix") and vim.bo[buf].modified then
        vim.cmd("write")
        require("conform").format({ async = true })
    end
end

function auto_save.setup()
    vim.api.nvim_create_autocmd({ "InsertLeave", "BufLeave" }, {
        callback = auto_save.save,
    })
    vim.api.nvim_create_autocmd("ModeChanged", {
        pattern = "i:*",
        callback = auto_save.save,
    })
    vim.api.nvim_create_autocmd("TextChanged", {
        callback = auto_save.save,
    })
end

auto_save.setup()

return {}
