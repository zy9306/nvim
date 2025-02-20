return {
    {
        "yetone/avante.nvim",
        event = "BufReadPost",
        opts = {
            provider = "openai",
            -- provider = "litellm",
            vendors = {
                litellm = {
                    __inherited_from = "openai",
                    api_key_name = "LITELLM_API_KEY",
                    endpoint = os.getenv("LITELLM_API_ENDPOINT"),
                    model = "claude3.5-sonnet",
                },
            },
        },
        build = "make",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
            {
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        use_absolute_path = true,
                    },
                },
            },
            {
                "MeanderingProgrammer/render-markdown.nvim",
                opts = {
                    file_types = { "markdown", "Avante" },
                    heading = {
                        enabled = false,
                    },
                },
                ft = { "markdown", "Avante" },
            },
        },
        config = function(_, opts)
            require("avante").setup(opts)
            vim.keymap.set(
                "n",
                "<leader>A",
                ":AvanteToggle<CR>",
                { noremap = true, silent = true, desc = "toggle Avante" }
            )
        end,
    },

    -- {
    --     "CopilotC-Nvim/CopilotChat.nvim",
    --     event = "BufReadPost",
    --     build = "make tiktoken",
    --     config = function()
    --         require("CopilotChat").setup()
    --         vim.keymap.set(
    --             "n",
    --             "<leader>C",
    --             ":CopilotChatToggle<CR>",
    --             { noremap = true, silent = true, desc = "toggle CopilotChat" }
    --         )
    --     end,
    -- },

    {
        "olimorris/codecompanion.nvim",
        event = "BufEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        init = function()
            require("plugins.codecompanion.fidget-spinner"):init()
        end,
        config = function()
            require("codecompanion").setup({
                opts = {
                    language = "Chinese",
                },
                adapters = {
                    openai = function()
                        return require("codecompanion.adapters").extend("openai", {
                            schema = {
                                model = {
                                    default = "gpt-4o",
                                },
                            },
                        })
                    end,
                    copilot = function()
                        return require("codecompanion.adapters").extend("copilot", {
                            schema = {
                                model = {
                                    default = "o1-2024-12-17",
                                },
                            },
                        })
                    end,
                },
                strategies = {
                    chat = {
                        adapter = "copilot",
                        slash_commands = {
                            ["buffer"] = {
                                opts = {
                                    provider = "telescope",
                                },
                            },
                        },
                        keymaps = {
                            close = {
                                modes = { n = "<Esc>", i = "<Esc>" },
                            },
                        },
                    },
                    inline = {
                        adapter = "openai",
                    },
                },
            })
            vim.keymap.set(
                { "n", "v" },
                "<leader>cc",
                ":CodeCompanionChat Toggle<CR>",
                { noremap = true, silent = true, desc = "Toggle CodeCompanionChat" }
            )

            vim.keymap.set(
                { "n", "v" },
                "<leader>cC",
                ":CodeCompanionChat<CR>",
                { noremap = true, silent = true, desc = "Open CodeCompanionChat" }
            )
            vim.keymap.set(
                { "n", "v" },
                "<leader>ca",
                ":CodeCompanionActions<CR>",
                { noremap = true, silent = true, desc = "Open CodeCompanionActions" }
            )
        end,
    },
}
