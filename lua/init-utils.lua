do
	local toggle_state = false

	function toggle_cursor_position()
		if not toggle_state then
			vim.api.nvim_command("normal! zz")
		else
			vim.api.nvim_command("normal! zt")
		end
		toggle_state = not toggle_state
	end

	-- vim.keymap.set({ "n", "v" }, "<leader><Space>", toggle_cursor_position, { noremap = true, silent = true })
	-- vim.keymap.set({ "i" }, "<C-L>", toggle_cursor_position, { noremap = true, silent = true })

	vim.keymap.set({ "n", "v" }, "<leader><Space>", "zz", { noremap = true, silent = true })
	vim.keymap.set({ "i" }, "<C-L>", "<C-o>zz", { noremap = true, silent = true })
end

do
	local function set_local_highlight()
		if vim.o.background == "light" then
			vim.cmd("highlight LocalHighlight guifg=#333333 guibg=#cccccc")
		else
			vim.cmd("highlight LocalHighlight guifg=#dcd7ba guibg=#2d4f67")
		end
	end

	set_local_highlight()

	vim.api.nvim_create_autocmd("OptionSet", {
		pattern = "background",
		callback = set_local_highlight,
	})
end

do
	function copy_to_clipboard(content)
		vim.fn.setreg("+", content)
		print("Copied to clipboard: " .. content)
	end

	function copy_current_file_path()
		local filepath = vim.fn.expand("%:p")
		copy_to_clipboard(filepath)
	end

	function copy_current_file_relative_path()
		local filepath = vim.fn.expand("%")
		copy_to_clipboard(filepath)
	end

	function copy_current_file_name()
		local filename = vim.fn.expand("%:t")
		copy_to_clipboard(filename)
	end

	vim.keymap.set("n", "<leader>yP", ":lua copy_current_file_path()<CR>", { noremap = true, silent = true, desc = "copy full path" })
	vim.keymap.set("n", "<leader>yp", ":lua copy_current_file_relative_path()<CR>", { noremap = true, silent = true, desc = "copy relative path" })
	vim.keymap.set("n", "<leader>yf", ":lua copy_current_file_name()<CR>", { noremap = true, silent = true, desc = "copy file name" })
end

do
	function close_buffers_in_cwd()
		local cwd = vim.fn.getcwd()
		local buffers = vim.api.nvim_list_bufs()

		for _, buf in ipairs(buffers) do
			local bufname = vim.api.nvim_buf_get_name(buf)
			if bufname:find(cwd, 1, true) == 1 then
				if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
					vim.api.nvim_buf_delete(buf, { force = true })
				end
			end
		end
	end

	function close_buffers_not_in_cwd()
		local cwd = vim.fn.getcwd()
		local buffers = vim.api.nvim_list_bufs()

		for _, buf in ipairs(buffers) do
			local bufname = vim.api.nvim_buf_get_name(buf)
			if not bufname:find(cwd, 1, true) == 1 then
				if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
					vim.api.nvim_buf_delete(buf, { force = true })
				end
			end
		end
	end

	vim.api.nvim_create_user_command("CloseCwdBuffers", close_buffers_in_cwd, {})

	vim.api.nvim_create_user_command("CloseNotCwdBuffers", close_buffers_not_in_cwd, {})
end

do
	function clear_highlight()
		vim.cmd("nohlsearch")
	end

	vim.api.nvim_create_user_command("ClearHighlight", clear_highlight, {})
end

do
	function delete_buffer()
		local buffers = vim.fn.getbufinfo({ buflisted = 1 })
		if #buffers == 1 then
			vim.cmd("enew")
			vim.cmd("bdelete #")
		else
			vim.cmd("b#|bd#")
		end
	end

	vim.api.nvim_create_user_command("Bdelete", delete_buffer, {})
end
