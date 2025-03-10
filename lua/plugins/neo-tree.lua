return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        event = "BufEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            vim.keymap.set(
                "n",
                "<leader>fb",
                ":Neotree source=buffers toggle=true<cr>",
                { desc = "Toggle Neotree buffers" }
            )
            vim.keymap.set("n", "<leader>fn", ":Neotree toggle=true<cr>", { desc = "Toggle Neotree filesystem" })
            require("neo-tree").setup({
                window = {
                    width = 35,
                    mappings = {
                        ["E"] = function()
                            vim.api.nvim_exec("Neotree focus filesystem left", true)
                        end,
                        ["B"] = function()
                            vim.api.nvim_exec("Neotree focus buffers left", true)
                        end,
                        ["G"] = function()
                            vim.api.nvim_exec("Neotree focus git_status left", true)
                        end,
                    },
                },
                filesystem = {
                    commands = {
                        avante_add_files = function(state)
                            local node = state.tree:get_node()
                            local filepath = node:get_id()
                            local relative_path = require("avante.utils").relative_path(filepath)

                            local sidebar = require("avante").get()

                            local open = sidebar:is_open()
                            if not open then
                                require("avante.api").ask()
                                sidebar = require("avante").get()
                            end

                            sidebar.file_selector:add_selected_file(relative_path)

                            if not open then
                                sidebar.file_selector:remove_selected_file("neo-tree filesystem [1]")
                            end
                        end,
                    },
                    window = {
                        mappings = {
                            ["bd"] = "noop",
                            ["D"] = "delete",
                            ["oa"] = "avante_add_files",
                        },
                    },
                },
                buffers = {
                    mappings = {
                        ["bd"] = "noop",
                        ["d"] = "buffer_delete",
                    },
                },
            })
        end,
    },
}
