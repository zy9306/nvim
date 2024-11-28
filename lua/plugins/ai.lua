return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		opts = {
			provider = "openai",
		},
		build = "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						use_absolute_path = true,
					},
				},
			},
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
		config = function(_, opts)
			require("avante").setup(opts)
			vim.keymap.set("n", "<leader>A", function()
				require("avante").toggle()
			end, { noremap = true, silent = true, desc = "toggle Avante" })
		end,
	},
}
