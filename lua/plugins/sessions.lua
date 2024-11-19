return {
	{
		"folke/persistence.nvim",
		-- event = "BufReadPre",
		opts = {
			need = 0,
			branch = true,
		},
		config = function()
			require("persistence").setup()
			vim.keymap.set("n", "<leader>qs", function()
				require("persistence").load()
			end, { desc = "Load session" })

			vim.keymap.set("n", "<leader>qS", function()
				require("persistence").select()
			end, { desc = "Select session" })

			vim.keymap.set("n", "<leader>ql", function()
				require("persistence").load({ last = true })
			end, { desc = "Load last session" })

			vim.keymap.set("n", "<leader>qd", function()
				require("persistence").stop()
			end, { desc = "Stop Persistence" })
		end,
	},
}