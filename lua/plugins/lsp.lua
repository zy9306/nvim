return {
	{
		"rmagatti/goto-preview",
		event = "BufEnter",
		config = function()
			require("goto-preview").setup({
				default_mappings = true,
				opacity = 40,
				focus_on_open = false,
				dismiss_on_move = false,
			})
		end,
	},
}
