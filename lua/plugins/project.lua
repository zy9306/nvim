return {
	-- {
	-- 	"ahmedkhalf/project.nvim",
	-- 	config = function()
	-- 		require("project_nvim").setup({
	-- 			show_hidden = false,
	-- 			scope_chdir = "tab",
	-- 			silent_chdir = false,
	-- 		})
	-- 		require("telescope").load_extension("projects")
	-- 	end,
	-- },
	{
		"notjedi/nvim-rooter.lua",
		event = "BufEnter",
		config = function()
			require("nvim-rooter").setup({})
		end,
	},
}
