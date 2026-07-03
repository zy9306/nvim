local M = {}

local tmp_dir = vim.fn.stdpath("config") .. "/tmp_files"

local function ensure_tmp_dir()
	vim.fn.mkdir(tmp_dir, "p")
end

local function tmp_path()
	ensure_tmp_dir()

	local timestamp = vim.fn.strftime("%Y%m%d_%H%M%S")
	local path = string.format("%s/tmp_%s.md", tmp_dir, timestamp)

	if vim.uv.fs_stat(path) == nil then
		return path
	end

	local index = 2
	while true do
		local candidate = string.format("%s/tmp_%s_%d.md", tmp_dir, timestamp, index)
		if vim.uv.fs_stat(candidate) == nil then
			return candidate
		end
		index = index + 1
	end
end

local function read_tmp_file(path)
	local ok, lines = pcall(vim.fn.readfile, path)
	if ok then
		return lines, nil
	end

	return { string.format("[failed to read %s]", path) }, string.format("failed to read %s", path)
end

local function has_content(lines)
	for _, line in ipairs(lines) do
		if line:match("%S") then
			return true
		end
	end

	return false
end

local function tmp_files()
	ensure_tmp_dir()

	local files = vim.fn.globpath(tmp_dir, "tmp_*", false, true)
	files = vim.tbl_filter(function(path)
		local stat = vim.uv.fs_stat(path)
		return stat ~= nil and stat.type == "file"
	end, files)

	table.sort(files, function(a, b)
		return vim.fn.fnamemodify(a, ":t") > vim.fn.fnamemodify(b, ":t")
	end)

	return files
end

local function delete_existing_join_buffer()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_name(buf):match("TmpFilesJoined$") then
			pcall(vim.api.nvim_buf_delete, buf, { force = true })
		end
	end
end

local function open_join_target(line_targets)
	local row = vim.api.nvim_win_get_cursor(0)[1]
	local target = line_targets[row]
	if target == nil then
		vim.notify("Move cursor to a tmp file section", vim.log.levels.INFO)
		return
	end

	vim.cmd.edit(vim.fn.fnameescape(target.path))

	local line_count = vim.api.nvim_buf_line_count(0)
	vim.api.nvim_win_set_cursor(0, { math.min(target.line, line_count), 0 })
end

function M.new()
	local path = tmp_path()
	vim.fn.writefile({}, path)
	vim.cmd.edit(vim.fn.fnameescape(path))
end

function M.join()
	local files = tmp_files()
	if #files == 0 then
		vim.notify("No tmp files found in " .. tmp_dir, vim.log.levels.INFO)
		return
	end

	local entries = {}
	local deleted_empty_count = 0
	for _, path in ipairs(files) do
		local file_lines, read_error = read_tmp_file(path)
		if read_error == nil and not has_content(file_lines) then
			local ok, delete_error = pcall(vim.fn.delete, path)
			if ok and delete_error == 0 then
				deleted_empty_count = deleted_empty_count + 1
			else
				table.insert(
					entries,
					{ path = path, lines = { string.format("[failed to delete empty file %s]", path) } }
				)
			end
		else
			table.insert(entries, { path = path, lines = file_lines })
		end
	end

	if #entries == 0 then
		vim.notify(string.format("Deleted %d empty tmp file(s)", deleted_empty_count), vim.log.levels.INFO)
		return
	end

	local lines = {}
	local line_targets = {}
	for file_index, entry in ipairs(entries) do
		if file_index > 1 then
			table.insert(lines, "")
		end

		local path = entry.path
		local title_line = #lines + 1
		table.insert(lines, string.format("===== %s =====", vim.fn.fnamemodify(path, ":t")))
		line_targets[title_line] = { path = path, line = 1 }

		local spacer_line = #lines + 1
		table.insert(lines, "")
		line_targets[spacer_line] = { path = path, line = 1 }

		for source_line, line in ipairs(entry.lines) do
			local joined_line = #lines + 1
			table.insert(lines, line)
			line_targets[joined_line] = { path = path, line = source_line }
		end
	end

	delete_existing_join_buffer()

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_name(buf, "TmpFilesJoined")
	vim.api.nvim_set_current_buf(buf)

	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].swapfile = false
	vim.bo[buf].filetype = "markdown"
	vim.bo[buf].modifiable = true
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].modified = false
	vim.bo[buf].modifiable = false

	vim.keymap.set("n", "<CR>", function()
		open_join_target(line_targets)
	end, { buffer = buf, desc = "Open tmp file section" })
	vim.keymap.set("n", "gf", function()
		open_join_target(line_targets)
	end, { buffer = buf, desc = "Open tmp file section" })
end

function M.setup()
	vim.api.nvim_create_user_command("TmpNew", M.new, { desc = "Open a new tmp file" })
	vim.api.nvim_create_user_command("TmpJoin", M.join, { desc = "Join tmp files into a buffer view" })
end

return M
