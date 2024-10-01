return {
	{
		"AckslD/swenv.nvim",
		config = function()
			require("swenv").setup({
				venvs_path = vim.fn.expand("~/Envs"),
			})
			vim.api.nvim_create_user_command("Venv", function()
				require("swenv.api").pick_venv()
			end, {})
		end,
	},
}
