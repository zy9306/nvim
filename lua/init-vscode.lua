local opts = {
	noremap = true,
	silent = true,
}

vim.keymap.set({ "n", "v" }, "<leader>ff", ":lua require('vscode').action('workbench.action.quickOpen')<cr>", opts)
