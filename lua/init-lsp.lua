require("mason").setup()
require("mason-lspconfig").setup()

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "gR", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
end

local servers = { "clangd", "rust_analyzer", "gopls", "pyright", "dartls" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

vim.diagnostic.config({ virtual_text = false, float = { border = "rounded" } })
vim.keymap.set("n", "<leader>!!", ":lua vim.diagnostic.open_float()<CR>", { desc = "Open diagnostics" })
vim.keymap.set("n", "<leader>!e", "<cmd>Telescope diagnostics severity=ERROR<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>!a", "<cmd>Telescope diagnostics<CR>", { noremap = true, silent = true })
