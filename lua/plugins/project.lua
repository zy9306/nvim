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
        config = function()
            require("nvim-rooter").setup({
                -- 目录是软链接时，自动切根目录会跳到真实路径所在项目，
                -- 这里改成手动模式，保持从当前项目启动时的工作目录不变。
				-- 需要时再手动 :Rooter
                manual = true,
            })
        end,
    },
}
