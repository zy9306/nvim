return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
            file_types = { "markdown", "Avante" },
            heading = {
                enabled = false,
            },
        },
        ft = { "Avante" },
    },
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        ft = { "markdown" },
        config = function()
            require("markview").setup({
                preview = {
                    enable = false,
                },
            })
        end,
    },
}
