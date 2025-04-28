return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            image = { enabled = true },
            input = { enabled = true },
            picker = {
                enabled = true,
                previewers = {
                    file = {
                        max_size = 5 * 1024 * 1024,
                    },
                },
            },
        },
        config = function(_, opts)
            require("snacks").setup(opts)

            vim.keymap.set({ "n" }, "<leader><leader>", function()
                Snacks.picker.resume()
            end, { desc = "snacks resume" })

            vim.keymap.set({ "n" }, "<leader>r", function()
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

            vim.keymap.set({ "n" }, "<leader>fj", function()
                Snacks.picker.jumps()
            end, { desc = "Jumps" })

            vim.keymap.set({ "n" }, "<leader>fB", function()
                Snacks.picker.git_branches()
            end, { desc = "Git Branches" })

            vim.keymap.set({ "n" }, "<leader>b", function()
                Snacks.picker.buffers({
                    current = false,
                })
            end, { desc = "snacks buffers" })

            vim.keymap.set({ "n", "v" }, "<leader>S", function()
                -- Snacks.picker.grep()
                Snacks.picker.grep_word({ regex = true, live = true })
            end, { desc = "snacks grep word" })

            -- use telescope
            -- vim.keymap.set({ "n", "v" }, "<leader>s", function()
            --     Snacks.picker.lines({
            --         layout = {
            --             -- preview = false,
            --             preset = "select",
            --         },
            --     })
            -- end, { desc = "snacks grep buffer" })

            vim.keymap.set({ "n" }, "<leader>fP", function()
                Snacks.picker.projects()
            end, { desc = "snacks projects" })

            vim.keymap.set({ "n" }, "<F8>", function()
                Snacks.explorer.open()
            end, { desc = "snacks projects" })

            -- lsp start
            vim.keymap.set({ "n" }, "<leader>ld", function()
                Snacks.picker.lsp_definitions()
            end, { desc = "Goto Definition" })
            vim.keymap.set({ "n" }, "<leader>lD", function()
                Snacks.picker.lsp_declarations()
            end, { desc = "Goto Declaration" })
            vim.keymap.set({ "n" }, "<leader>lr", function()
                Snacks.picker.lsp_references()
            end, { desc = "References" })
            vim.keymap.set({ "n" }, "<leader>li", function()
                Snacks.picker.lsp_implementations()
            end, { desc = "Goto Implementation" })
            vim.keymap.set({ "n" }, "<leader>lt", function()
                Snacks.picker.lsp_type_definitions()
            end, { desc = "Goto Type Definition" })
            vim.keymap.set(
                "n",
                "<leader>la",
                ":lua vim.lsp.buf.code_action()<CR>",
                { noremap = true, silent = true, desc = "LSP Code Action" }
            )
            -- lsp end
        end,
    },
}
