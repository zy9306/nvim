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
			-- use wezterm
			-- vim.keymap.set("n", "<C-t>", ":ToggleTerm direction=float<CR>", { noremap = true, silent = true })
			-- vim.keymap.set("t", "<C-t>", "<C-\\><C-n>:ToggleTerm direction=float<CR>", { noremap = true, silent = true })
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
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},

	{
		"akinsho/git-conflict.nvim",
		event = "VeryLazy",
		version = "*",
		config = true,
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
		cmd = "AerialToggle",
		keys = {
			{ "<leader>I", "<cmd>AerialToggle!<CR>", desc = "outline toggle" },
		},
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

	-- NOTE: 如果要启用,将以下两个都改成 true
	{
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hlchunk").setup({
				chunk = {
					enable = true,
					-- 禁用动画
					delay = 0,
					chars = {
						right_arrow = "─",
					},
				},
				indent = {
					enable = true,
				},
			})
		end,
	},

	{ "taybart/b64.nvim", event = "VeryLazy" },

	{
		"NeogitOrg/neogit",
		event = "BufReadPre",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = true,
	},

	{ "sindrets/diffview.nvim" },

	{
		"gbprod/yanky.nvim",
		event = "BufReadPost",
		config = function()
			require("yanky").setup()

			vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")

			vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
			vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
			vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
			vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

			vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
			vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")

			vim.keymap.set(
				{ "n", "v" },
				"<leader>Y",
				':lua require("telescope").extensions.yank_history.yank_history()<cr>',
				{ desc = "Yank history" }
			)
		end,
	},

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
