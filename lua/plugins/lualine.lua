return {
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
				},
				sections = {
					lualine_c = {
						{
							function()
								local cwd = vim.fn.getcwd()
								local home = vim.env.HOME
								if cwd:sub(1, #home) == home then
									cwd = "~" .. cwd:sub(#home + 1)
								end
								return " " .. cwd
							end,
						},
						{ "filename", path = 1 },
					},
				},
			})
		end,
	},
}
