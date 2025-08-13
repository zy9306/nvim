return {
    {
        "saghen/blink.cmp",
        dependencies = { "fang2hou/blink-copilot" },
        opts = {
            keymap = {
                preset = "default",
                ["<CR>"] = { "accept", "fallback" },
            },

            snippets = { preset = "luasnip" },

            appearance = {
                nerd_font_variant = "mono",
            },

            completion = { documentation = { auto_show = false } },

            sources = {
                default = { "lsp", "copilot", "path", "snippets", "buffer" },
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-copilot",
                        score_offset = 100,
                        async = true,
                    },
                },
            },

            fuzzy = { implementation = "lua" },
        },

        opts_extend = { "sources.default" },
    },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        event = "InsertEnter",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
        end,
    },
    {
        "chrisgrieser/nvim-scissors",
        event = "VeryLazy",
        opts = {
            snippetDir = vim.fn.stdpath("config") .. "/snippets",
            jsonFormatter = { "prettier", "-w", "--parser", "json" },
        },
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                filetypes = {
                    ["*"] = true,
                },
            })
        end,
    },
    -- {
    --     "zbirenbaum/copilot-cmp",
    --     event = "InsertEnter",
    --     config = function()
    --         require("copilot_cmp").setup()
    --         require("copilot").setup({
    --             suggestion = { enabled = false },
    --             panel = { enabled = false },
    --         })
    --     end,
    -- },
}
