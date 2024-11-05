return {
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				parser_install_dir = "~/.local/share/nvim/lazy/nvim-treesitter/parser",
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
					disable = { "python" },
				},
				disable = { "yaml" },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "vv",
						node_incremental = "vv",
						node_decremental = "vV",
					},
				},
			})
		end,
	},

	-- {
	-- 	"nvim-treesitter/nvim-treesitter-context",
	-- 	config = function()
	-- 		require("treesitter-context").setup({
	-- 			enable = true,
	-- 			max_lines = 0,
	-- 			min_window_height = 0,
	-- 			line_numbers = true,
	-- 			multiline_threshold = 20,
	-- 			trim_scope = "outer",
	-- 			mode = "cursor",
	-- 			separator = nil,
	-- 			zindex = 20,
	-- 			on_attach = nil,
	-- 		})
	-- 	end,
	-- },
}
