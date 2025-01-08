return {
    -- https://github.com/MagicDuck/grug-far.nvim
    {
        "MagicDuck/grug-far.nvim",
        config = function()
            require("grug-far").setup({})
            vim.keymap.set("n", "<leader>%%", '<cmd>lua require("grug-far").open(opts)<CR>', {
                desc = "Run grug-far",
            })
        end,
    },

    -- https://github.com/nvim-pack/nvim-spectre
    -- 文档中说一定要用 ESC 退出插入模式
    {
        "nvim-pack/nvim-spectre",
        event = "VeryLazy",
        config = function()
            require("spectre").setup()
            vim.keymap.set("n", "<leader>%s", '<cmd>lua require("spectre").toggle()<CR>', {
                desc = "Toggle Spectre",
            })
        end,
    },

    -- TODO 这个可以修改 quickfix 的内容, 但是 grug-far 应该已经足够了
    -- https://github.com/gabrielpoca/replacer.nvim
}
