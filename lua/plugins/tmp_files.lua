return {
    {
        dir = vim.fn.stdpath("config"),
        name = "tmp-files",
        lazy = false,
        config = function()
            require("tmp_files").setup()
        end,
    },
}
