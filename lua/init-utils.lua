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

do
	vim.api.nvim_create_user_command("ToggleReadonly", function()
		if vim.bo.readonly then
			vim.bo.readonly = false
			print("Readonly disabled")
		else
			vim.bo.readonly = true
			print("Readonly enabled")
		end
	end, {})
end

do
	local function find_project_root(patterns)
		local path = vim.fn.expand("%:p:h")
		while path and path ~= "/" do
			for _, pattern in ipairs(patterns) do
				if vim.fn.glob(path .. "/" .. pattern) ~= "" then
					return path
				end
			end
			path = vim.fn.fnamemodify(path, ":h")
		end
		return nil
	end

	local function set_tab_name()
		local root = find_project_root({ ".git" })
		if root then
			local project_name = vim.fn.fnamemodify(root, ":t")
			vim.cmd("Tabby rename_tab " .. project_name)
		end
	end

	vim.api.nvim_create_autocmd("BufEnter", {
		callback = set_tab_name,
	})
end
