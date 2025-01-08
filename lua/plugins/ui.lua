return {
    -- or use nvim-telescope/telescope-ui-select.nvim
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        opts = {},
        config = function()
            require("dressing").setup({})
        end,
    },
}
