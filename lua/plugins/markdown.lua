return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
            enabled = true,
            file_types = { "markdown" },
            anti_conceal = { enabled = false },
            heading = { enabled = false },
            -- paragraph = { enabled = false },
            -- code = { enabled = false },
            -- dash = { enabled = false },
            -- document = { enabled = false },
            -- bullet = { enabled = false },
            -- checkbox = { enabled = false },
            -- quote = { enabled = false },
            -- callout = { enabled = false },
            -- link = { enabled = false },
            -- latex = { enabled = false },
            -- html = { enabled = false },
            indent = { enabled = false },
            -- sign = { enabled = false },
            pipe_table = {
                enabled = true,
                style = "full",
            },
        },
    },
    -- {
    --     "OXY2DEV/markview.nvim",
    --     lazy = true,
    --     ft = { "markdown" },
    --     config = function()
    --         require("markview").setup({
    --             preview = {
    --                 enable = false,
    --             },
    --         })
    --     end,
    -- },
}
