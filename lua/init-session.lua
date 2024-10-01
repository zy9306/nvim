local config_dir = vim.fn.stdpath("config")
local session_directory = config_dir .. "/data/sessions/"

if vim.fn.isdirectory(session_directory) == 0 then
	vim.fn.mkdir(session_directory, "p")
end

local current_session = nil

local default_session = "session.vim"

local function get_session_files()
	return vim.fn.readdir(session_directory)
end

local function save_session(session_name)
	session_name = session_name or ""
	current_session = session_name
	vim.cmd("mksession! " .. session_directory .. session_name)
end

local function load_session(session_name)
	if vim.fn.filereadable(session_directory .. session_name) == 1 then
		current_session = session_name
		vim.cmd("source " .. session_directory .. session_name)
	else
		print("Session file " .. session_name .. " does not exist.")
	end
end

vim.api.nvim_create_user_command("SaveSession", function(opts)
	local session_files = get_session_files()
	local default_session_name = current_session or ""

	vim.ui.input({ prompt = "Enter new session name: ", default = default_session_name }, function(input)
		if input then
			save_session(input)
		end
	end)

	-- vim.ui.select(session_files, { prompt = "Select session to save (or create new):" }, function(choice)
	-- 	if choice then
	-- 		save_session(choice)
	-- 	else
	-- 		vim.ui.input({ prompt = "Enter new session name: ", default = default_session_name }, function(input)
	-- 			if input then
	-- 				save_session(input)
	-- 			end
	-- 		end)
	-- 	end
	-- end)
end, { nargs = "?" })

vim.api.nvim_create_user_command("LoadSession", function(opts)
	local session_files = get_session_files()
	if #session_files == 0 then
		print("No session files found.")
		return
	end

	local session_name = opts.args ~= "" and opts.args or current_session or default_session

	vim.ui.select(session_files, { prompt = "Select session to load:" }, function(choice)
		if choice then
			load_session(choice)
		end
	end)
end, { nargs = "?" })
