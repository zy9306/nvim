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
                        return math.floor(vim.o.columns * 0.3)
                    end
                end,
                start_in_insert = true,
                direction = "vertical",
            })
            local opts = { noremap = true, silent = true }
            -- vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
            vim.keymap.set("n", "<C-t>", ":ToggleTerm<CR>", opts)
            vim.keymap.set(
                "n",
                "<leader><C-t>",
                ":lua require('toggleterm.terminal').Terminal:new({ direction = 'horizontal' }):toggle()<CR>",
                opts
            )
            vim.keymap.set(
                "n",
                "<leader>v<C-t>",
                ":lua require('toggleterm.terminal').Terminal:new({ direction = 'vertical' }):toggle()<CR>",
                opts
            )

            vim.keymap.set("t", "<C-t>", "<C-\\><C-n>:ToggleTerm<CR>", opts)

            vim.keymap.set("t", "<C-Up>", "<C-\\><C-n>:resize -2<CR>", opts)
            vim.keymap.set("t", "<C-Down>", "<C-\\><C-n>:resize +2<CR>", opts)
            vim.keymap.set("t", "<C-Left>", "<C-\\><C-n>:vertical resize -2<CR>", opts)
            vim.keymap.set("t", "<C-Right>", "<C-\\><C-n>:vertical resize +2<CR>", opts)

            -- vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
            -- vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
            -- vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
            -- vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
            vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)

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

    {
        "willothy/flatten.nvim",
        lazy = false,
        priority = 1001,
        config = function()
            require("flatten").setup({
                window = {
                    open = "alternate",
                },
            })
        end,
    },
}
