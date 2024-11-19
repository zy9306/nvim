return {
	{
		"tomasky/bookmarks.nvim",
		event = "BufEnter",
		config = function()
			require("bookmarks").setup({
				on_attach = function(bufnr)
					require("telescope").load_extension("bookmarks")
					local bm = require("bookmarks")
					local map = vim.keymap.set
					map("n", "mm", bm.bookmark_toggle)
					map("n", "mi", bm.bookmark_ann)
					map("n", "mc", bm.bookmark_clean)
					map("n", "mn", bm.bookmark_next)
					map("n", "mp", bm.bookmark_prev)
					-- map("n", "ml", bm.bookmark_list)
					map("n", "ml", ":Telescope bookmarks list<CR>")
					map("n", "mx", bm.bookmark_clear_all)
				end,
			})
		end,
	},
}
