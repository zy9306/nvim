return {
    {
        "mikavilpas/yazi.nvim",
        event = "VeryLazy",
        dependencies = {
            { "nvim-lua/plenary.nvim", lazy = true },
        },
        keys = {
            {
                "<leader>-",
                mode = { "n", "v" },
                "<cmd>Yazi<cr>",
                desc = "Open yazi at the current file",
            },
            {
                "<leader>W",
                "<cmd>Yazi cwd<cr>",
                desc = "Open the file manager in nvim's working directory",
            },
            {
                "<leader>w",
                "<cmd>Yazi toggle<cr>",
                desc = "Resume the last yazi session",
            },
        },
    },
}
