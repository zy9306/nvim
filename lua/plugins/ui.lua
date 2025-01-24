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
    {
        "nvim-zh/colorful-winsep.nvim",
        event = { "WinLeave" },
        config = function()
            require("colorful-winsep").setup({})
        end,
    },
}
