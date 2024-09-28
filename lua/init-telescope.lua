local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local extensions = telescope.extensions

local selected_theme = "dropdown"

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close,
			},
		},
	},
	pickers = {
		find_files = { theme = selected_theme },
		live_grep = { theme = selected_theme },
		marks = { theme = selected_theme },
		buffers = {
			theme = selected_theme,
			ignore_current_buffer = true,
			sort_mru = true,
			sort_lastused = true,
		},
		help_tags = { theme = selected_theme },
		commands = { theme = selected_theme },
		current_buffer_fuzzy_find = { theme = selected_theme },
		lsp_references = { theme = selected_theme },
		lsp_definitions = { theme = selected_theme },
		lsp_implementations = { theme = selected_theme },
		lsp_document_symbols = { theme = selected_theme },
		diagnostics = {
			layout_config = {
				prompt_position = "top",
			},
			sorting_strategy = "ascending",
		},
	},
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
})

function get_current_word_or_selection()
	local search_text = ""
	if vim.fn.mode() == "v" or vim.fn.mode() == "V" or vim.fn.mode() == "" then
		vim.cmd('normal! "vy')
		search_text = vim.fn.getreg("v")
	else
		-- search_text = vim.fn.expand("<cword>")
	end
	return search_text
end

function global_search_current_word_or_selection()
	search_text = get_current_word_or_selection()
	builtin.live_grep({ default_text = search_text })
end

function buffer_search_current_word_or_selection()
	search_text = get_current_word_or_selection()
	builtin.current_buffer_fuzzy_find({ default_text = search_text })
end

vim.keymap.set({ "n", "v" }, "<leader>x", builtin.commands, { desc = "Commands" })

vim.keymap.set({ "n", "v" }, "<leader>ff", builtin.find_files, { desc = "Find Files" })
vim.keymap.set({ "n", "v" }, "<leader>fG", global_search_current_word_or_selection, { desc = "Live Grep" })
vim.keymap.set({ "n", "v" }, "<leader>G", global_search_current_word_or_selection, { desc = "Live Grep" })
vim.keymap.set({ "n", "v" }, "<leader>S", global_search_current_word_or_selection, { desc = "Live Grep" })
vim.keymap.set({ "n", "v" }, "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set({ "n", "v" }, "<leader>b", builtin.buffers, { desc = "Buffers" })
vim.keymap.set({ "n", "v" }, "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
vim.keymap.set({ "n", "v" }, "<leader>fg", buffer_search_current_word_or_selection, { desc = "Current Buffer Fuzzy Find" })
vim.keymap.set({ "n", "v" }, "<leader>g", buffer_search_current_word_or_selection, { desc = "Current Buffer Fuzzy Find" })
vim.keymap.set({ "n", "v" }, "<leader>s", buffer_search_current_word_or_selection, { desc = "Current Buffer Fuzzy Find" })

-- marks START
function set_auto_global_mark()
	local marks = vim.fn.getmarklist()

	local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

	local used_marks = {}
	for _, mark in ipairs(marks) do
		local mark_name = mark.mark:sub(2)
		if #mark_name == 1 and alphabet:find(mark_name) then
			used_marks[mark_name] = true
		end
	end

	for i = 1, #alphabet do
		local mark_char = alphabet:sub(i, i)
		if not used_marks[mark_char] then
			vim.cmd("mark " .. mark_char)
			print("Set mark: " .. mark_char)
			return
		end
	end

	local mark_char = alphabet:sub(1, 1)
	vim.cmd("mark " .. mark_char)
	print("All marks used. Overwriting mark: " .. mark_char)
end

vim.api.nvim_set_keymap("n", "<leader>a", ":lua set_auto_global_mark()<CR>", { noremap = true, silent = true })

vim.keymap.set({ "n", "v" }, "<leader>M", ":Telescope marks mark_type=all theme=dropdown<CR>", { desc = "Show All marks" })

vim.keymap.set({ "n", "v" }, "<leader>m", ':lua require("telescope.builtin").marks({ cwd = vim.fn.getcwd() })<CR>', { desc = "Show project marks" })
-- marks END

vim.keymap.set("n", "<leader>fr", ":Telescope frecency theme=dropdown<cr>", { desc = "Frecency" })
vim.keymap.set("n", "<leader>fp", ":Telescope file_browser path=%:p:h<cr>", { desc = "File Browser" })

-- lsp integration
vim.keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", { noremap = true, silent = true, desc = "LSP References" })
vim.keymap.set("n", "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", { noremap = true, silent = true, desc = "LSP Definitions" })
vim.keymap.set("n", "<leader>li", "<cmd>Telescope lsp_implementations<CR>", { noremap = true, silent = true, desc = "LSP Implementations" })
vim.keymap.set("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", { noremap = true, silent = true, desc = "LSP Document Symbols" })
