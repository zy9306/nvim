return {
    -- {
    -- 	"famiu/bufdelete.nvim",
    -- 	event = "BufEnter",
    -- },

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
        "stevearc/stickybuf.nvim",
        event = "BufEnter",
        config = function()
            require("stickybuf").setup({})
        end,
    },

    {
        "BranimirE/fix-auto-scroll.nvim",
        config = true,
        event = "VeryLazy",
    },
}
