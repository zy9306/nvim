return {
    {
        dir = vim.fn.stdpath("config"),
        name = "tmp-files",
        lazy = false,
        keys = {
            {
                "<leader>tn",
                function()
                    require("tmp_files").new()
                end,
                desc = "Open a new tmp file",
            },
            {
                "<leader>tj",
                function()
                    require("tmp_files").join()
                end,
                desc = "Join tmp files",
            },
        },
        config = function()
            require("tmp_files").setup()
        end,
    },
}
