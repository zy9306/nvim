return {
    {
        "nvim-zh/colorful-winsep.nvim",
        event = { "WinLeave" },
        config = function()
            require("colorful-winsep").setup({})
        end,
    },

    {
        "j-hui/fidget.nvim",
        event = "BufEnter",
        config = function()
            require("fidget").setup({})
        end,
    },

    { "danilamihailov/beacon.nvim" },
}
