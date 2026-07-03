return {
	{
		dir = vim.fn.stdpath("config") .. "/local_plugins/git-branch-workspace",
		name = "git-branch-workspace",
		cmd = "GitBranchWorkspace",
		config = function()
			require("git_branch_workspace").setup()
		end,
	},
}
