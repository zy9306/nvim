return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		config = function()
			local function my_on_attach(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				api.config.mappings.default_on_attach(bufnr)

				vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
				vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
			end
			require("nvim-tree").setup({
				on_attach = my_on_attach,
				diagnostics = {
					enable = true,
				},
				sync_root_with_cwd = true,
				respect_buf_cwd = true,
				update_focused_file = {
					enable = true,
					update_cwd = true,
				},
				sort = {
					sorter = "case_sensitive",
				},
				view = {
					width = 30,
					adaptive_size = false,
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = false,
					git_ignored = false,
				},
				actions = {
					open_file = {
						resize_window = false,
					},
				},
			})

			-- NOTE: Lazy Install 时会报错, 但不影响使用
			local function close_nvim_tree(data)
				local status, nvim_tree = pcall(require, "nvim-tree.api")
				if not status then
					print("Failed to load nvim-tree")
					return
				end
				if nvim_tree and nvim_tree.tree and nvim_tree.tree.close then
					nvim_tree.tree.close()
				else
					print("nvim-tree API is not available")
				end
			end

			vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = close_nvim_tree })
			vim.keymap.set("n", "<leader>ft", ":NvimTreeToggle<cr>", { desc = "nvim-tree: Toggle" })
		end,
	},
}
