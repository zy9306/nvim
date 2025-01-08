local opts = {
    noremap = true,
    silent = true,
}

vim.keymap.set({ "n" }, "<leader>ff", ":lua require('vscode').action('workbench.action.quickOpen')<cr>", opts)
vim.keymap.set({ "n" }, "<leader>b", ":lua require('vscode').action('workbench.action.quickOpen')<cr>", opts)
vim.keymap.set({ "n" }, "<leader>x", ":lua require('vscode').action('workbench.action.showCommands')<cr>", opts)
vim.keymap.set({ "n" }, "<leader>w", ":lua require('vscode').action('workbench.action.files.save')<cr>", opts)
vim.keymap.set({ "n" }, "<leader>S", ":lua require('vscode').action('workbench.action.findInFiles')<cr>", opts)
