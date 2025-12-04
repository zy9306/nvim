return {
    {
        "NickvanDyke/opencode.nvim",
        dependencies = {
            { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
        },
        config = function()
            vim.keymap.set({ "n", "x" }, "<C-a>", function()
                require("opencode").ask("@this: ", { submit = true })
            end, { desc = "Ask opencode" })

            vim.keymap.set({ "n", "x" }, "<C-x>", function()
                require("opencode").select()
            end, { desc = "Execute opencode action…" })

            vim.keymap.set({ "n", "x" }, "ga", function()
                require("opencode").prompt("@this")
            end, { desc = "Add to opencode" })

            vim.keymap.set({ "n", "t" }, "<C-.>", function()
                require("opencode").toggle()
            end, { desc = "Toggle opencode" })

            vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
            vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
        end,
    },
}
