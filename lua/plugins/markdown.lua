return {
    -- {
    --     "MeanderingProgrammer/render-markdown.nvim",
    --     opts = {
    --         file_types = { "markdown", "Avante" },
    --         heading = {
    --             enabled = false,
    --         },
    --     },
    --     ft = { "markdown", "Avante" },
    -- },
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        ft = { "markdown", "Avante" },
        config = function()
            require("markview").setup({
                preview = {
                    enable = false,
                },
            })
        end,
    },
}
