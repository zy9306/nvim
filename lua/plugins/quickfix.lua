return {
    {
        "stevearc/quicker.nvim",
        event = "FileType qf",
        opts = {},
        config = function()
            vim.keymap.set("n", "<leader>Q", function()
                require("quicker").toggle()
            end, {
                desc = "Toggle quickfix",
            })
            require("quicker").setup({
                keys = {
                    {
                        ">",
                        function()
                            require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
                        end,
                        desc = "Expand quickfix context",
                    },
                    {
                        "<",
                        function()
                            require("quicker").collapse()
                        end,
                        desc = "Collapse quickfix context",
                    },
                },
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "qf",
                callback = function()
                    vim.api.nvim_buf_set_keymap(0, "n", "<Tab>", "<CR><C-W><C-P>", { noremap = true, silent = true })
                end,
            })
        end,
    },
}
