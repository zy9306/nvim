local opts = {
    noremap = true,
    silent = true,
}

vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

vim.keymap.set("n", "<leader>wh", "<C-w>h", opts)
vim.keymap.set("n", "<leader>wj", "<C-w>j", opts)
vim.keymap.set("n", "<leader>wk", "<C-w>k", opts)
vim.keymap.set("n", "<leader>wl", "<C-w>l", opts)

vim.keymap.set("n", "<leader>ws", "<C-w>s", opts)
vim.keymap.set("n", "<leader>wv", "<C-w>v", opts)

vim.keymap.set("n", "<leader>wc", "<C-w>c", opts)
vim.keymap.set("n", "<leader>wo", "<C-w>o", opts)

return {
    {
        "yorickpeterse/nvim-window",
        event = "BufEnter",
        config = function()
            require("nvim-window").setup({})
            vim.keymap.set(
                "n",
                "<leader>ww",
                "<cmd>lua require('nvim-window').pick()<cr>",
                { noremap = true, silent = true, desc = "nvim-window: Jump to window" }
            )
        end,
    },
}
