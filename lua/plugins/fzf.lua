return {
	{
		"ibhagwan/fzf-lua",
		event = "BufEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local actions = require("fzf-lua.actions")
			require("fzf-lua").setup({
				grep = {
					actions = {
						["ctrl-q"] = {
							fn = actions.file_edit_or_qf,
							prefix = "select-all+",
						},
					},
				},
				winopts = {
					backdrop = 100,
				},
			})
		end,
	},
}
