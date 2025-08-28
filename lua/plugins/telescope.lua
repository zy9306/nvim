return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            telescope.setup({
                defaults = {
                    -- 背景透明度
                    winblend = 15,
                    mappings = {
                        -- i = {
                        --     ["<esc>"] = actions.close,
                        -- },
                    },
                    layout_config = {
                        prompt_position = "top",
                    },
                    sorting_strategy = "ascending",
                },
                pickers = {
                    buffers = {
                        ignore_current_buffer = true,
                        sort_mru = true,
                        sort_lastused = true,
                        mappings = {
                            i = {
                                ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
                            },
                        },
                    },
                    diagnostics = {
                        layout_config = {
                            prompt_position = "top",
                        },
                        sorting_strategy = "ascending",
                    },
                },
            })
        end,
    },
    {
        "nvim-telescope/telescope-live-grep-args.nvim",
        config = function()
            lga_actions = require("telescope-live-grep-args.actions")
            require("telescope").setup({
                extensions = {
                    live_grep_args = {
                        mappings = {
                            i = {
                                ["<C-k>"] = lga_actions.quote_prompt(),
                                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                            },
                        },
                    },
                },
            })
            require("telescope").load_extension("live_grep_args")
        end,
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        opts = {
            extensions = {
                file_browser = {
                    layout_config = {
                        prompt_position = "top",
                    },
                    sorting_strategy = "ascending",
                    hidden = { file_browser = true, folder_browser = true },
                    no_ignore = true,
                },
            },
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("file_browser")
            vim.keymap.set("n", "<leader>fp", ":Telescope file_browser path=%:p:h<cr>", { desc = "File Browser" })
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        opts = {
            extensions = {
                fzf = {
                    fuzzy = false,
                },
            },
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("fzf")
        end,
    },

    {
        "jonarrien/telescope-cmdline.nvim",
        keys = {
            { "<leader>x", "<cmd>Telescope cmdline<CR>", desc = "Cmdline" },
        },
    },
    {
        "LukasPietzschmann/telescope-tabs",
        event = "BufEnter",
        config = function()
            require("telescope").load_extension("telescope-tabs")
            require("telescope-tabs").setup({
                -- https://github.com/LukasPietzschmann/telescope-tabs/wiki/Configs#configs
                entry_formatter = function(tab_id, buffer_ids, file_names, file_paths, is_current)
                    local tab_name = require("tabby.feature.tab_name").get(tab_id)
                    return string.format("%d: %s%s", tab_id, tab_name, is_current and " <" or "")
                end,
                entry_ordinal = function(tab_id, buffer_ids, file_names, file_paths, is_current)
                    return require("tabby.feature.tab_name").get(tab_id)
                end,
            })
        end,
    },

    {
        "nvim-telescope/telescope-project.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("telescope").load_extension("project")
            vim.api.nvim_set_keymap(
                "n",
                "<leader><C-p>",
                ":lua require'telescope'.extensions.project.project{}<CR>",
                { noremap = true, silent = true }
            )
        end,
    },
}
