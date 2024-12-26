local telescope = require("telescope")
local builtin = require("telescope.builtin")
local extensions = telescope.extensions

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
	-- builtin.live_grep({ default_text = search_text })
	extensions.live_grep_args.live_grep_args({ default_text = search_text })
end

function buffer_search_current_word_or_selection()
	search_text = get_current_word_or_selection()
	-- builtin.current_buffer_fuzzy_find({ default_text = search_text })
	extensions.live_grep_args.live_grep_args({ default_text = search_text, search_dirs = { vim.fn.expand("%:p") } })
end

-- vim.keymap.set({ "n", "v" }, "<leader>x", builtin.commands, { desc = "Commands" })

vim.keymap.set({ "n", "v" }, "<leader>fP", ':lua require("telescope").extensions.projects.projects{}<cr>', { desc = "Project" })
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

vim.keymap.set({ "n", "v" }, "<leader>fT", ':lua require("telescope-tabs").list_tabs()<cr>', { desc = "List Tabs" })

-- lsp integration
vim.keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", { noremap = true, silent = true, desc = "LSP References" })
vim.keymap.set("n", "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", { noremap = true, silent = true, desc = "LSP Definitions" })
vim.keymap.set("n", "<leader>li", "<cmd>Telescope lsp_implementations<CR>", { noremap = true, silent = true, desc = "LSP Implementations" })
vim.keymap.set("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", { noremap = true, silent = true, desc = "LSP Document Symbols" })
vim.keymap.set("n", "<leader>la", ":lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true, desc = "LSP Code Action" })
