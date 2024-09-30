return {
	{ "nvim-tree/nvim-web-devicons" },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
		config = function()
			require("toggleterm").setup({
				start_in_insert = true,
			})
		end,
	},
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"airblade/vim-rooter",
		config = function()
			vim.g.rooter_silent_chdir = 1
			vim.g.rooter_patterns = { ".git", ".git/", ".gitignore", ".gitmodules", ".project" }
		end,
	},
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"antoinemadec/FixCursorHold.nvim",
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},

	{
		"johmsalas/text-case.nvim",
		config = function()
			require("textcase").setup({
				prefix = "gs",
			})
		end,
	},

	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = {},
	},

	{
		"tzachar/local-highlight.nvim",
		config = function()
			require("local-highlight").setup()
		end,
	},

	{ "terryma/vim-expand-region" },

	-- outline(imenu)
	{
		"stevearc/aerial.nvim",
		opts = {},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("aerial").setup({
				layout = {
					resize_to_content = false,
				},
			})
			vim.keymap.set("n", "<leader>I", "<cmd>AerialToggle!<CR>")
		end,
	},

	{
		"fedepujol/move.nvim",
		opts = {},
		config = function()
			require("move").setup()
			local opts = { noremap = true, silent = true }
			-- Normal-mode commands
			vim.keymap.set("n", "<A-j>", ":MoveLine(1)<CR>", opts)
			vim.keymap.set("n", "<A-k>", ":MoveLine(-1)<CR>", opts)
			vim.keymap.set("n", "<A-h>", ":MoveHChar(-1)<CR>", opts)
			vim.keymap.set("n", "<A-l>", ":MoveHChar(1)<CR>", opts)

			-- Visual-mode commands
			vim.keymap.set("v", "<A-j>", ":MoveBlock(1)<CR>", opts)
			vim.keymap.set("v", "<A-k>", ":MoveBlock(-1)<CR>", opts)
			vim.keymap.set("v", "<A-h>", ":MoveHBlock(-1)<CR>", opts)
			vim.keymap.set("v", "<A-l>", ":MoveHBlock(1)<CR>", opts)
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		config = function()
			require("ibl").setup()
			require("ibl").update({ enabled = false })
		end,
	},

	{ "taybart/b64.nvim", event = "VeryLazy" },

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = true })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}
