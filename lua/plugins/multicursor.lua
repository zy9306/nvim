return {
	"jake-stewart/multicursor.nvim",
	config = function()
		local mc = require("multicursor-nvim")

		mc.setup()

		local opts = {
			noremap = true,
			silent = true,
		}

		vim.keymap.set({ "n" }, "<A-up>", function()
			mc.addCursor("k")
		end, opts)
		vim.keymap.set({ "n" }, "<A-down>", function()
			mc.addCursor("j")
		end, opts)
		vim.keymap.set({ "v" }, "<c-m>", function()
			mc.addCursor("*")
		end, opts)
		vim.keymap.set({ "v" }, "<c-s>", function()
			mc.skipCursor("*")
		end, opts)

		vim.keymap.set({ "n", "v" }, "<A-left>", mc.nextCursor)
		vim.keymap.set({ "n", "v" }, "<A-right>", mc.prevCursor)

		vim.keymap.set({ "n", "v" }, "<c-leftmouse>", mc.handleMouse)

		vim.keymap.set("n", "<esc>", function()
			if not mc.cursorsEnabled() then
				mc.enableCursors()
			elseif mc.hasCursors() then
				mc.clearCursors()
			else
			end
		end)

		vim.keymap.set("n", "<C-c>", function()
			if not mc.cursorsEnabled() then
				mc.enableCursors()
			elseif mc.hasCursors() then
				mc.clearCursors()
			else
			end
		end)

		vim.keymap.set("v", "I", mc.insertVisual, opts)
		vim.keymap.set("v", "A", mc.appendVisual, opts)

		vim.keymap.set("v", "M", mc.matchCursors, opts)

		vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
		vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
		vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
		vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
	end,
}
