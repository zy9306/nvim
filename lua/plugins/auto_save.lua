-- local auto_save = {}
--
-- function auto_save.save()
--     local buf = vim.api.nvim_get_current_buf()
--     local buf_name = vim.api.nvim_buf_get_name(buf)
--     if
--         buf_name ~= ""
--         and not string.find(buf_name, "quickfix")
--         and not string.find(buf_name, "tmp")
--         and vim.bo[buf].modified
--     then
--         vim.cmd("write")
--         require("conform").format({ async = true })
--     end
-- end
--
-- function auto_save.safe_save()
--     local status, err = pcall(auto_save.save)
--     if not status then
--         vim.api.nvim_err_writeln("AutoSave Error: " .. err)
--     end
-- end
--
-- function auto_save.setup()
--     vim.api.nvim_create_autocmd({ "InsertLeave", "BufLeave" }, {
--         callback = auto_save.safe_save,
--     })
--     vim.api.nvim_create_autocmd("ModeChanged", {
--         pattern = "i:*",
--         callback = auto_save.safe_save,
--     })
--     vim.api.nvim_create_autocmd("TextChanged", {
--         callback = auto_save.safe_save,
--     })
-- end
--
-- auto_save.setup()

local excluded_filetypes = {
    "gitcommit",
    "NvimTree",
    "Outline",
    "TelescopePrompt",
    "alpha",
    "dashboard",
    "lazygit",
    "neo-tree",
    "oil",
    "prompt",
    "toggleterm",
}

local excluded_filenames = {
    "",
}

local function save_condition(buf)
    local buf = vim.api.nvim_get_current_buf()
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if
        vim.tbl_contains(excluded_filetypes, vim.fn.getbufvar(buf, "&filetype"))
        or vim.tbl_contains(excluded_filenames, vim.fn.expand("%:t"))
        or buf_name == ""
        or string.find(buf_name, "tmp")
        or string.find(buf_name, "quickfix")
    then
        return false
    end

    local first_lines = vim.api.nvim_buf_get_lines(buf, 0, 3, false)
    for _, line in ipairs(first_lines) do
        if string.find(string.lower(line), "auto%-save:%s*off") then
            return false
        end
    end

    return true
end

return {
    {
        "okuuva/auto-save.nvim",
        cmd = "ASToggle",
        event = { "InsertLeave", "TextChanged" },
        config = function()
            require("auto-save").setup({
                condition = save_condition,
            })
        end,
    },
}
