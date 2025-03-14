return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            image = { enabled = true },
            input = { enabled = true },
            picker = { enabled = true },
        },
        config = function()
            vim.keymap.set({ "n" }, "<leader><leader>", function()
                Snacks.picker.smart()
            end, { desc = "snacks smart find files" })

            vim.keymap.set({ "n" }, "<leader>fd", function()
                Snacks.picker.git_diff()
            end, { desc = "snacks git diff" })

            vim.keymap.set({ "n" }, "<leader>ff", function()
                Snacks.picker.files()
            end, { desc = "snacks files" })

            vim.keymap.set({ "n" }, "<leader>fF", function()
                Snacks.picker.files({
                    hidden = true,
                    ignored = true,
                })
            end, { desc = "snacks files" })

            vim.keymap.set({ "n" }, "<leader>b", function()
                Snacks.picker.buffers({
                    current = false,
                })
            end, { desc = "snacks buffers" })

            vim.keymap.set({ "n", "v" }, "<leader>S", function()
                Snacks.picker.grep()
            end, { desc = "snacks grep" })

            vim.keymap.set({ "n", "v" }, "<leader>s", function()
                Snacks.picker.grep_buffers()
            end, { desc = "snacks grep buffers" })
        end,
    },
}
