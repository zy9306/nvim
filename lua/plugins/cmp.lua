return {
    {
        "saghen/blink.cmp",
        opts = {
            keymap = {
                preset = "default",
                ["<CR>"] = { "accept", "fallback" },
                ["<Tab>"] = {
                    function(cmp)
                        cmp.hide()
                        require("copilot.suggestion").next()
                        return true
                    end,
                },
                ["<S-Tab>"] = {
                    function(cmp)
                        cmp.hide()
                        require("copilot.suggestion").prev()
                        return true
                    end,
                },
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
                        accept_word = "<C-Right>",
                        -- accept_line = "<C-l>",
                        next = "<Tab>",
                        prev = "<S-Tab>",
                        dismiss = "<C-]>",
                    },
                },
            })
            local copilot_suggestion = require("copilot.suggestion")
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
