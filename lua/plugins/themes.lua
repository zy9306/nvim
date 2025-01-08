return {
    -- {
    -- 	"projekt0n/github-nvim-theme",
    -- 	lazy = false,
    -- 	priority = 1000,
    -- 	config = function()
    -- 		require("github-theme").setup({})
    --
    -- 		vim.cmd("colorscheme github_light")
    -- 	end,
    -- },
    -- {
    -- 	"folke/tokyonight.nvim",
    -- 	lazy = false,
    -- 	priority = 1000,
    -- 	opts = {},
    -- 	config = function()
    -- 		vim.cmd([[colorscheme tokyonight]])
    -- 	end,
    -- },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "auto",
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
