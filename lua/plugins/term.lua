return {
    {
        "akinsho/toggleterm.nvim",
        event = "BufEnter",
        version = "*",
        config = true,
        config = function()
            require("toggleterm").setup({
                size = function(term)
                    if term.direction == "horizontal" then
                        return math.floor(vim.o.lines * 0.3)
                    elseif term.direction == "vertical" then
                        return 50
                    end
                end,
                start_in_insert = true,
                direction = "horizontal",
            })
            local opts = { noremap = true, silent = true }
            vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
            vim.keymap.set("n", "<C-t>", ":ToggleTerm direction=horizontal<CR>", opts)
            vim.keymap.set("t", "<C-t>", "<C-\\><C-n>:ToggleTerm direction=horizontal<CR>", opts)
        end,
    },
}
