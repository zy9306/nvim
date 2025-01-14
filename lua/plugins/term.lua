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
                        return math.floor(vim.o.lines * 0.4)
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

            local terms = require("toggleterm.terminal")
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "term://*",
                callback = function()
                    if vim.fn.mode() ~= "t" then
                        local _, term = terms.identify()
                        if term then
                            term:set_mode(terms.mode.INSERT)
                        end
                    end
                end,
            })

            vim.api.nvim_create_autocmd("ModeChanged", {
                pattern = "v:*",
                callback = function()
                    if vim.bo.buftype == "terminal" then
                        local _, term = terms.identify()
                        if term then
                            term:set_mode(terms.mode.INSERT)
                        end
                    end
                end,
            })

            vim.api.nvim_create_autocmd("TermOpen", {
                callback = function()
                    vim.keymap.set("n", "q", "<Cmd>startinsert<CR>", { buffer = true, noremap = true, silent = true })
                end,
            })
        end,
    },
}
