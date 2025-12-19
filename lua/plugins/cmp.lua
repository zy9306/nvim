return {
    {
        "saghen/blink.cmp",
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
                default = { "lsp", "path", "snippets", "buffer" },
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
                suggestion = {
                    auto_trigger = true,
                    keymap = {
                        accept = "<C-l>",
                        accept_word = false,
                        next = false,
                        prev = false,
                        dismiss = "<C-]>",
                    },
                },
            })

            local copilot_suggestion = require("copilot.suggestion")

            vim.keymap.set("i", "<Tab>", function()
                if copilot_suggestion.is_visible() then
                    copilot_suggestion.accept_word()
                else
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", true)
                end
            end, { noremap = true, silent = true, desc = "Accept Copilot suggestion or insert Tab" })

            vim.keymap.set("i", "<C-n>", function()
                if copilot_suggestion.is_visible() then
                    copilot_suggestion.next()
                else
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, false, true), "n", true)
                end
            end, { noremap = true, silent = true, desc = "Next Copilot suggestion or normal C-n" })

            vim.keymap.set("i", "<C-p>", function()
                if copilot_suggestion.is_visible() then
                    copilot_suggestion.prev()
                else
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, false, true), "n", true)
                end
            end, { noremap = true, silent = true, desc = "Previous Copilot suggestion or normal C-p" })

            vim.keymap.set("i", "<C-c>", function()
                if copilot_suggestion.is_visible() then
                    copilot_suggestion.dismiss()
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
                else
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
                end
            end, { noremap = true, silent = true, desc = "Dismiss Copilot suggestion and exit insert mode" })
        end,
    },
}
