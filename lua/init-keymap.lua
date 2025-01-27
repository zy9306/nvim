local opts = {
    noremap = true,
    silent = true,
}

vim.keymap.set("n", "<C-I>", "<C-I>", opts)

vim.keymap.set("x", "p", '"_dP', opts)

vim.keymap.set({ "n", "v" }, "<leader><Space>", "zz", { noremap = true, silent = true })

vim.keymap.set({ "i" }, "<C-B>", "<Left>", opts)
vim.keymap.set({ "i" }, "<C-F>", "<Right>", opts)
-- vim.keymap.set({ "i" }, "<C-A>", "<Home>", opts)
-- vim.keymap.set({ "i" }, "<C-E>", "<End>", opts)
-- vim.keymap.set({ "i" }, "<C-N>", "<Down>", opts)
-- vim.keymap.set({ "i" }, "<C-P>", "<Up>", opts)

vim.keymap.set("i", "<C-_>", "<C-o>u", opts)

vim.cmd("cnoremap <C-F> <Right>")
vim.cmd("cnoremap <C-B> <Left>")
vim.cmd("cnoremap <C-A> <Home>")
vim.cmd("cnoremap <C-E> <End>")

-- vim.keymap.set("n", "<C-Left>", "<C-w>h", opts)
-- vim.keymap.set("n", "<C-Down>", "<C-w>j", opts)
-- vim.keymap.set("n", "<C-Up>", "<C-w>k", opts)
-- vim.keymap.set("n", "<C-Right>", "<C-w>l", opts)

vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- term keymap
vim.keymap.set("t", "<C-Up>", "<C-\\><C-n>:resize -2<CR>", opts)
vim.keymap.set("t", "<C-Down>", "<C-\\><C-n>:resize +2<CR>", opts)
vim.keymap.set("t", "<C-Left>", "<C-\\><C-n>:vertical resize -2<CR>", opts)
vim.keymap.set("t", "<C-Right>", "<C-\\><C-n>:vertical resize +2<CR>", opts)

-- vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
-- vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
-- vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
-- vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
-- term keymap end

-- vim.keymap.set("n", "<C-k>", ":resize -2<CR>", opts)
-- vim.keymap.set("n", "<C-j>", ":resize +2<CR>", opts)
-- vim.keymap.set("n", "<C-h>", ":vertical resize -2<CR>", opts)
-- vim.keymap.set("n", "<C-l>", ":vertical resize +2<CR>", opts)

vim.keymap.set("n", "<A-Right>", ":bnext<CR>", opts)
vim.keymap.set("n", "<A-Left>", ":bprevious<CR>", opts)
