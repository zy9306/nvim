function toggle_winfixbuf()
    vim.wo.winfixbuf = not vim.wo.winfixbuf
    if vim.wo.winfixbuf then
        print("winfixbuf enabled")
    else
        print("winfixbuf disabled")
    end
end

vim.api.nvim_create_user_command("ToggleWinfixbuf", toggle_winfixbuf, {})

return {
    {
        "j-morano/buffer_manager.nvim",
        event = "BufEnter",
        config = function()
            require("buffer_manager").setup({})
            vim.keymap.set(
                "n",
                "<leader>B",
                ':lua require("buffer_manager.ui").toggle_quick_menu()<cr>',
                { noremap = true, silent = true, desc = "Buffer Manager" }
            )
        end,
    },

    {
        "BranimirE/fix-auto-scroll.nvim",
        config = true,
        event = "VeryLazy",
    },

    {
        "leath-dub/snipe.nvim",
        keys = {
            {
                "B",
                function()
                    require("snipe").open_buffer_menu()
                end,
                desc = "Open Snipe buffer menu",
            },
        },
        opts = {},
    },

    {
        "carbon-steel/detour.nvim",
        config = function()
            require("detour").setup({})
            vim.keymap.set("n", "<c-w><enter>", ":Detour<cr>")
            vim.keymap.set("n", "<c-w>.", ":DetourCurrentWindow<cr>")
        end,
    },
}
