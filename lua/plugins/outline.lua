return {
    -- outline(imenu)
    -- {
    --     "stevearc/aerial.nvim",
    --     cmd = "AerialToggle",
    --     keys = {
    --         { "<leader>I", "<cmd>AerialToggle!<CR>", desc = "outline toggle" },
    --     },
    --     opts = {},
    --     dependencies = {
    --         "nvim-treesitter/nvim-treesitter",
    --         "nvim-tree/nvim-web-devicons",
    --     },
    --     config = function()
    --         require("aerial").setup({
    --             layout = {
    --                 resize_to_content = false,
    --             },
    --         })
    --     end,
    -- },

    {
        "oskarrrrrrr/symbols.nvim",
        config = function()
            local r = require("symbols.recipes")
            require("symbols").setup(r.DefaultFilters, r.AsciiSymbols, {})
            vim.keymap.set("n", "<leader>I", "<cmd>SymbolsToggle<CR>")
        end,
    },
}
