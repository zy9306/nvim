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

    -- {
    --     "oskarrrrrrr/symbols.nvim",
    --     config = function()
    --         local r = require("symbols.recipes")
    --         require("symbols").setup(r.DefaultFilters, r.AsciiSymbols, {})
    --         vim.keymap.set("n", "<leader>I", "<cmd>SymbolsToggle<CR>")
    --     end,
    -- },

    {
        "hedyhli/outline.nvim",
        lazy = true,
        cmd = { "Outline", "OutlineOpen" },
        keys = {
            { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
        },
        opts = {
            keymaps = {
                goto_location = { "<CR>", "<LeftRelease>" },
            },
        },
    },
}
