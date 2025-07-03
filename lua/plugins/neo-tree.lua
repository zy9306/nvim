function ensure_normal_mode_for_neo_tree()
    local buftype = vim.api.nvim_buf_get_option(0, "filetype")
    if buftype == "neo-tree" then
        vim.cmd("stopinsert")
    end
end

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = ensure_normal_mode_for_neo_tree,
})

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
            vim.keymap.set("n", "<F9>", ":Neotree source=buffers toggle=true<cr>", { desc = "Toggle Neotree buffers" })

            vim.keymap.set(
                "n",
                "<F8>",
                ":Neotree toggle=true position=float<cr>",
                { desc = "Toggle Neotree filesystem" }
            )
            require("neo-tree").setup({
                window = {
                    width = 35,
                    position = "float",
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

                        ["+"] = { "nvim_aider_add", desc = "add to aider" },
                        ["-"] = { "nvim_aider_drop", desc = "drop from aider" },
                        ["="] = { "nvim_aider_add_read_only", desc = "add read-only to aider" },
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
