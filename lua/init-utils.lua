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
	local function switch_to_previous_buffer()
		local prev_buf = vim.fn.bufnr("#")
		if prev_buf ~= -1 then
			vim.cmd("buffer " .. prev_buf)
		end
	end

	local function delete_buffer(force)
		local buffers = vim.fn.getbufinfo({ buflisted = 1 })
		local cmd = force and "bdelete!" or "bdelete"

		if #buffers == 1 then
			vim.cmd("enew")
			local ok, err = pcall(vim.cmd, cmd .. " #")
			if not ok then
				switch_to_previous_buffer()
				vim.notify("Error deleting buffer: " .. err, vim.log.levels.ERROR)
			end
		else
			local ok, err = pcall(vim.cmd, "b#|" .. cmd .. " #")
			if not ok then
				switch_to_previous_buffer()
				vim.notify("Error deleting buffer: " .. err, vim.log.levels.ERROR)
			end
		end
	end

	vim.api.nvim_create_user_command("Bdelete", function(opts)
		delete_buffer(opts.bang)
	end, { bang = true })
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

	-- local function set_tab_name()
	-- 	local root = find_project_root({ ".git" })
	-- 	if root then
	-- 		local project_name = vim.fn.fnamemodify(root, ":t")
	-- 		vim.cmd("Tabby rename_tab " .. project_name)
	-- 	end
	-- end

	-- vim.api.nvim_create_autocmd("BufEnter", {
	-- 	callback = set_tab_name,
	-- })

	local function set_wezterm_tab_name()
		local root = find_project_root({ ".git" })
		if root then
			local project_name = vim.fn.fnamemodify(root, ":t")
			local tab_title = "nvim: " .. project_name
			vim.loop.spawn("wezterm", {
				args = { "cli", "set-tab-title", tab_title },
			}, function(code, signal)
				if code ~= 0 then
					vim.schedule(function()
						vim.notify("Failed to set WezTerm tab title", vim.log.levels.WARN)
					end)
				end
			end)
		end
	end

	local function create_wezterm_tab()
		local root = find_project_root({ ".git" })
		if root then
			local project_name = vim.fn.fnamemodify(root, ":t")
			local tab_title = "shell: " .. project_name
			local stdout = vim.loop.new_pipe(false)
			local stderr = vim.loop.new_pipe(false)

			vim.loop.spawn("wezterm", {
				args = { "cli", "list", "--format", "json" },
				stdio = { nil, stdout, stderr },
			}, function(code, signal)
				if code == 0 then
					stdout:read_start(function(err, data)
						assert(not err, err)
						if data then
							local tabs = vim.json.decode(data)
							local tab_id = nil

							for _, tab in ipairs(tabs) do
								if tab.tab_title == tab_title then
									tab_id = tab.tab_id
									break
								end
							end

							if tab_id then
								vim.loop.spawn("wezterm", {
									args = { "cli", "activate-tab", "--tab-id", tab_id },
								})
							else
								local spawn_stdout = vim.loop.new_pipe(false)
								vim.loop.spawn("wezterm", {
									args = { "cli", "spawn" },
									stdio = { nil, spawn_stdout, stderr },
								}, function(spawn_code)
									if spawn_code == 0 then
										spawn_stdout:read_start(function(err, data)
											assert(not err, err)
											if data then
												local pane_id = data
												if pane_id then
													local command = string.format(
														'echo "wezterm cli set-tab-title \\"%s\\"\n" | wezterm cli send-text --no-paste --pane-id %s',
														tab_title,
														pane_id
													)
													local result = os.execute(command)
													if result ~= 0 then
														vim.schedule(function()
															vim.notify("Failed to execute command", vim.log.levels.WARN)
														end)
													end
												else
													vim.schedule(function()
														vim.notify("Failed to retrieve pane_id", vim.log.levels.WARN)
													end)
												end
											end
										end)
									else
										vim.schedule(function()
											vim.notify("Failed to spawn new WezTerm tab", vim.log.levels.WARN)
										end)
									end
								end)
							end
						end
					end)
				else
					vim.schedule(function()
						vim.notify("Failed to list WezTerm tabs", vim.log.levels.WARN)
					end)
				end
			end)
		end
	end

	vim.api.nvim_create_user_command("CreateWeztermTab", function()
		create_wezterm_tab()
	end, {})

	vim.api.nvim_create_autocmd("BufEnter", {
		callback = set_wezterm_tab_name,
	})
end
