return {
	{
		"Bekaboo/dropbar.nvim",
		event = "BufEnter",
		config = function()
			require("dropbar").setup()
		end,
	},
}
