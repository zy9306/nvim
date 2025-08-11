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

            vim.keymap.set("n", "<F8>", ":Neotree toggle=true<cr>", { desc = "Toggle Neotree filesystem" })

            require("neo-tree").setup({
                enable_opened_markers = true,
                default_component_configs = {
                    name = {
                        highlight_opened_files = "all",
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

                        ["+"] = { "nvim_aider_add", desc = "add to aider" },
                        ["-"] = { "nvim_aider_drop", desc = "drop from aider" },
                        ["="] = { "nvim_aider_add_read_only", desc = "add read-only to aider" },
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
                        enabled = true,
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
