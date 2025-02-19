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
                        ["bd"] = "noop",
                        ["d"] = "buffer_delete",
                        ["D"] = "delete",
                    },
                },
                buffers = {
                    mappings = {
                        ["bd"] = "noop",
                    },
                },
            })
        end,
    },
}
