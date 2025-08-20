return {
    {
        "stevearc/oil.nvim",
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "oil",
                callback = function(args)
                    vim.keymap.set("n", "<C-c>", "<Esc>", { buffer = args.buf, noremap = true, silent = true })
                    vim.keymap.set("i", "<C-c>", "<Esc>", { buffer = args.buf, noremap = true, silent = true })
                end,
            })

            require("oil").setup({
                -- :Oil --trash / to view trash
                delete_to_trash = true,
                view_options = {
                    show_hidden = true,
                },
            })
        end,
    },
}
