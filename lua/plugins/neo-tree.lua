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

            vim.keymap.set("n", "<F8>", function()
                require("neo-tree.command").execute({
                    source = "filesystem",
                    position = "left",
                    reveal_file = vim.fn.expand("%:p"),
                    toggle = true,
                })
            end, { desc = "Toggle Neotree filesystem" })

            local function copy_to_clipboard(content)
                vim.fn.setreg("+", content)
                print("Copied to clipboard: " .. content)
            end

            local function get_neo_tree_node_path(state)
                local node = state.tree:get_node()
                return node.path or node:get_id()
            end

            local function copy_neo_tree_node_name(state)
                local node = state.tree:get_node()
                local name = node.name or vim.fn.fnamemodify(get_neo_tree_node_path(state), ":t")
                copy_to_clipboard(name)
            end

            local function copy_neo_tree_node_path(state, use_absolute_path)
                local path = get_neo_tree_node_path(state)
                if not use_absolute_path then
                    path = vim.fn.fnamemodify(path, ":.")
                end
                copy_to_clipboard(path)
            end

            require("neo-tree").setup({
                enable_opened_markers = true,
                default_component_configs = {
                    name = {
                        -- highlight_opened_files = "all",
                    },
                },
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
                        ["<leader>yf"] = {
                            copy_neo_tree_node_name,
                            desc = "copy file name",
                        },
                        ["<leader>yp"] = {
                            function(state)
                                copy_neo_tree_node_path(state, false)
                            end,
                            desc = "copy relative path",
                        },
                        ["<leader>yP"] = {
                            function(state)
                                copy_neo_tree_node_path(state, true)
                            end,
                            desc = "copy absolute path",
                        },
                    },
                },
                filesystem = {
                    window = {
                        mappings = {
                            ["bd"] = "noop",
                            ["D"] = "delete",
                        },
                    },
                    follow_current_file = {
                        enabled = false,
                        leave_dirs_open = true,
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
