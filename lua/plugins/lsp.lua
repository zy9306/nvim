return {
	{
		"williamboman/mason.nvim",
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			local on_attach = function(client, bufnr)
				local function buf_set_keymap(...)
					vim.api.nvim_buf_set_keymap(bufnr, ...)
				end
				local opts = { noremap = true, silent = true }
				buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
				buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
				buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
				buf_set_keymap("n", "gR", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
			end

			local installed_servers = require("mason-lspconfig").get_installed_servers()
			local required_servers = { "clangd", "rust_analyzer", "gopls", "pyright", "dartls" }

			local servers = vim.tbl_extend("force", installed_servers, required_servers)

			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end

			lspconfig.pyright.setup({
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					client.handlers["textDocument/publishDiagnostics"] = function(...) end
				end,
				settings = {
					pyright = {
						disableOrganizeImports = true,
					},
					python = {
						analysis = {
							ignore = { "*" },
						},
					},
				},
			})

			lspconfig.ruff.setup({
				trace = "messages",
				init_options = {
					settings = {
						logLevel = "debug",
					},
				},
			})

			vim.diagnostic.config({ virtual_text = false, float = { border = "rounded" } })

			vim.keymap.set("n", "<leader>!!", ":lua vim.diagnostic.open_float()<CR>", { desc = "Open diagnostics" })
			vim.keymap.set("n", "<leader>!e", "<cmd>Telescope diagnostics severity=ERROR<CR>", { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>!a", "<cmd>Telescope diagnostics<CR>", { noremap = true, silent = true })
		end,
	},
	{
		"rmagatti/goto-preview",
		event = "BufReadPre",
		config = function()
			require("goto-preview").setup({
				default_mappings = true,
				opacity = 40,
				focus_on_open = false,
				dismiss_on_move = false,
			})
		end,
	},
	-- 有点干扰视线, 暂时不用了, 用 tab 查看函数签名
	-- {
	-- 	"ray-x/lsp_signature.nvim",
	-- 	event = "BufReadPre",
	-- 	opts = {},
	-- 	config = function(_, opts)
	-- 		require("lsp_signature").setup(opts)
	-- 	end,
	-- },

	{
		"soulis-1256/eagle.nvim",
		event = "BufReadPre",
		config = function()
			vim.o.mousemoveevent = true
			require("eagle").setup({
				mouse_mode = false,
				keyboard_mode = true,
			})
			vim.keymap.set("n", "<Tab>", ":EagleWin<CR>", { noremap = true, silent = true })
		end,
	},

	{
		"mfussenegger/nvim-lint",
		event = "BufReadPost",
		config = function()
			require("lint").linters_by_ft = {
				go = { "golangcilint" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
