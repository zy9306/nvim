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
