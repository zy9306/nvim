-- 自动更新终端标题为当前工作目录, 适用于 Alacritty, iTerm2, Kitty 等支持 ANSI 转义序列的终端
vim.api.nvim_create_autocmd({ "DirChanged", "VimEnter", "BufEnter" }, {
    callback = function()
        local cwd = vim.fn.getcwd()
        -- 发送转义序列到终端，设置标题
        vim.api.nvim_chan_send(
            vim.v.stderr, -- 通过 stderr 避免影响缓冲区内容
            string.format("\27]2;%s\a", cwd)
        )
    end,
})

vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
    pattern = "term://*",
    callback = function()
        vim.cmd("startinsert")
    end,
})

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*",
    callback = function(args)
        vim.keymap.set("v", "i", "<C-\\><C-n>i", { buffer = args.buf, silent = true })
    end,
})

vim.keymap.set("n", "<C-t>", function()
    vim.ui.input({ prompt = "Terminal name (optional): " }, function(input)
        if input == nil then
            return
        end

        vim.cmd("terminal")

        if input ~= "" then
            local buf = vim.api.nvim_get_current_buf()
            vim.api.nvim_buf_set_name(buf, "Term-" .. input)
        end
    end)
end, opts)
