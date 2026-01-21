local opts = {
    noremap = true,
    silent = true,
}

-- With Ctrl-t and Ctrl-g you can move between matches without leaving the search mode.
vim.keymap.set({ "n", "v" }, "<C-s>", "/")
vim.keymap.set("i", "<C-s>", "<Esc>/")

vim.keymap.set("n", ";", "<nop>", opts)
vim.keymap.set("n", "f", "<nop>", opts)

vim.api.nvim_set_keymap("n", "J", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "K", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "L", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "H", "<Nop>", { noremap = true, silent = true })

vim.keymap.set("", "<ScrollWheelRight>", "<Nop>", opts)

vim.keymap.set("n", "<MiddleMouse>", "<nop>", opts)
vim.keymap.set("n", "<2-MiddleMouse>", "<nop>", opts)
vim.keymap.set("n", "<3-MiddleMouse>", "<nop>", opts)
vim.keymap.set("n", "<4-MiddleMouse>", "<nop>", opts)

vim.keymap.set("n", "<C-I>", "<C-I>", opts)

vim.keymap.set("x", "p", '"_dP', opts)

vim.keymap.set({ "i" }, "<C-B>", "<Left>", opts)
vim.keymap.set({ "i" }, "<C-F>", "<Right>", opts)

vim.keymap.set("i", "<C-_>", "<C-o>u", opts)

vim.cmd("cnoremap <C-F> <Right>")
vim.cmd("cnoremap <C-B> <Left>")
vim.cmd("cnoremap <C-A> <Home>")
vim.cmd("cnoremap <C-E> <End>")

vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

vim.keymap.set("n", "<A-Right>", ":bnext<CR>", opts)
vim.keymap.set("n", "<A-Left>", ":bprevious<CR>", opts)

vim.keymap.set("n", "<leader>w", function()
    vim.cmd("w!")
end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>W", function()
    vim.cmd("wa!")
end, { noremap = true, silent = true })
