return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			telescope.setup({
				defaults = {
					-- 背景透明度
					winblend = 15,
					mappings = {
						i = {
							["<esc>"] = actions.close,
						},
					},
					layout_config = {
						prompt_position = "top",
					},
					sorting_strategy = "ascending",
				},
				pickers = {
					buffers = {
						ignore_current_buffer = true,
						sort_mru = true,
						sort_lastused = true,
					},
					diagnostics = {
						layout_config = {
							prompt_position = "top",
						},
						sorting_strategy = "ascending",
					},
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope-live-grep-args.nvim",
		config = function()
			require("telescope").load_extension("live_grep_args")
		end,
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		opts = {
			extensions = {
				frecency = {
					-- TODO: https://github.com/nvim-telescope/telescope-frecency.nvim/issues/270
					db_safe_mode = false,
				},
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("frecency")
			vim.keymap.set("n", "<leader>fr", ":Telescope frecency<cr>", { desc = "Frecency" })
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		opts = {
			extensions = {
				file_browser = {
					layout_config = {
						prompt_position = "top",
					},
					sorting_strategy = "ascending",
					hidden = { file_browser = true, folder_browser = true },
					no_ignore = true,
				},
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("file_browser")
			vim.keymap.set("n", "<leader>fp", ":Telescope file_browser path=%:p:h<cr>", { desc = "File Browser" })
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		opts = {
			extensions = {
				fzf = {
					fuzzy = false,
				},
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"debugloop/telescope-undo.nvim",
		opts = {
			extensions = {
				undo = {
					use_delta = true,
					use_custom_command = nil,
					side_by_side = false,
					vim_diff_opts = {
						ctxlen = vim.o.scrolloff,
					},
				},
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("undo")
			vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
		end,
	},

	{
		"jonarrien/telescope-cmdline.nvim",
		keys = {
			{ "<leader>x", "<cmd>Telescope cmdline<CR>", desc = "Cmdline" },
		},
	},
	{
		"LukasPietzschmann/telescope-tabs",
		event = "BufEnter",
		config = function()
			require("telescope").load_extension("telescope-tabs")
			require("telescope-tabs").setup({
				-- https://github.com/LukasPietzschmann/telescope-tabs/wiki/Configs#configs
				entry_formatter = function(tab_id, buffer_ids, file_names, file_paths, is_current)
					local tab_name = require("tabby.feature.tab_name").get(tab_id)
					return string.format("%d: %s%s", tab_id, tab_name, is_current and " <" or "")
				end,
				entry_ordinal = function(tab_id, buffer_ids, file_names, file_paths, is_current)
					return require("tabby.feature.tab_name").get(tab_id)
				end,
			})
		end,
	},

	-- {
	-- 	"nvim-telescope/telescope-ui-select.nvim",
	-- 	event = "BufEnter",
	-- 	opts = {
	-- 		extensions = {
	-- 			["ui-select"] = {
	-- 				require("telescope.themes").get_dropdown({}),
	-- 			},
	-- 		},
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("telescope").setup(opts)
	-- 		require("telescope").load_extension("ui-select")
	-- 	end,
	-- },
}
