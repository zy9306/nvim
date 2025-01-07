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
						{
							function()
								local filepath = vim.fn.expand("%:p")
								local last_modified = vim.fn.getftime(filepath)
								if last_modified > 0 then
									return os.date("Last Modified: %Y-%m-%d %H:%M:%S", last_modified)
								else
									return "File not saved"
								end
							end,
						},
					},
				},
			})
		end,
	},
}
