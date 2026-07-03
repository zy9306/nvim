local M = {}

local state = {
	tabs = {},
	branches = {},
}

local ns = vim.api.nvim_create_namespace("git_branch_workspace")

local function setup_highlights()
	vim.api.nvim_set_hl(0, "GitBranchWorkspaceCurrent", {
		link = "String",
	})

	vim.api.nvim_set_hl(0, "GitBranchWorkspaceHeader", {
		link = "Title",
	})
end

local function notify(message, level)
	vim.notify("[GitBranchWorkspace] " .. message, level or vim.log.levels.INFO)
end

local function run(command)
	local output = vim.fn.systemlist(command)
	return output, vim.v.shell_error
end

local function git_start_path()
	local buf_name = vim.api.nvim_buf_get_name(0)

	if buf_name ~= "" then
		local stat = vim.loop.fs_stat(buf_name)

		if stat ~= nil and stat.type == "file" then
			return vim.fn.fnamemodify(buf_name, ":p:h")
		elseif stat ~= nil and stat.type == "directory" then
			return buf_name
		end
	end

	return vim.fn.getcwd()
end

local function workspace_root()
	local workspace = state.tabs[tostring(vim.api.nvim_get_current_tabpage())]

	return workspace and workspace.root or nil
end

local function git_run(args)
	return run("git -C " .. vim.fn.shellescape(workspace_root() or git_start_path()) .. " " .. args)
end

local function git_root()
	local output, code = run("git -C " .. vim.fn.shellescape(git_start_path()) .. " rev-parse --show-toplevel")

	if code ~= 0 or output[1] == nil or output[1] == "" then
		return nil
	end

	return output[1]
end

local function current_branch()
	local output, code = git_run("symbolic-ref --quiet --short HEAD")

	if code == 0 and output[1] ~= nil and output[1] ~= "" then
		return output[1]
	end

	return nil
end

local function parse_branch_line(kind, line)
	local parts = vim.split(line, "\t", { plain = true })
	local full_name = parts[1]
	local name = parts[2]
	local remote, remote_branch = name:match("^([^/]+)/(.+)$")

	return {
		kind = kind,
		full_name = full_name,
		name = name,
		remote = remote,
		remote_branch = remote_branch,
		date = parts[3] or "",
		subject = table.concat(parts, "\t", 4),
	}
end

local function is_remote_pseudo_ref(ref)
	if ref.kind ~= "remote" or ref.remote_branch == nil then
		return false
	end

	return ref.remote_branch:match("^merge%-requests/")
		or ref.remote_branch:match("^pull/%d+")
		or ref.remote_branch:match("^mr/%d+$")
end

local function get_refs(kind, ref_prefix)
	local command = table.concat({
		"for-each-ref",
		"--sort=-committerdate",
		"--format='%(refname)%09%(refname:short)%09%(committerdate:relative)%09%(subject)'",
		ref_prefix,
	}, " ")
	local output, code = git_run(command)

	if code ~= 0 then
		return nil, table.concat(output, "\n")
	end

	local refs = {}

	for _, line in ipairs(output) do
		if line ~= "" and not line:match("^refs/remotes/.+/HEAD\t") then
			local ref = parse_branch_line(kind, line)

			if not is_remote_pseudo_ref(ref) then
				table.insert(refs, ref)
			end
		end
	end

	return refs, nil
end

local function get_branches()
	local local_branches, local_err = get_refs("local", "refs/heads")

	if local_branches == nil then
		return nil, local_err
	end

	local remote_branches, remote_err = get_refs("remote", "refs/remotes")

	if remote_branches == nil then
		return nil, remote_err
	end

	return {
		local_branches = local_branches,
		remote_branches = remote_branches,
	}, nil
end

local function local_branch_names()
	local names = {}
	local branches, err = get_refs("local", "refs/heads")

	if branches == nil then
		return nil, err
	end

	for _, branch in ipairs(branches) do
		names[branch.name] = true
	end

	return names, nil
end

local function tab_key(tab)
	return tostring(tab)
end

local function current_workspace()
	return state.tabs[tab_key(vim.api.nvim_get_current_tabpage())]
end

local function add_branch_lines(buf, lines, title, branches, current)
	table.insert(lines, title)

	for _, branch in ipairs(branches) do
		local marker = branch.kind == "local" and branch.name == current and "*" or " "
		table.insert(lines, marker .. " " .. branch.name)
		state.branches[buf][#lines] = branch
	end
end

local function set_branch_lines(buf)
	local refs, err = get_branches()
	local current = current_branch()
	local lines = {}

	state.branches[buf] = {}

	if refs == nil then
		lines = { err ~= "" and err or "Unable to load branches" }
	elseif #refs.local_branches == 0 and #refs.remote_branches == 0 then
		lines = { "No branches" }
	else
		if #refs.local_branches > 0 then
			add_branch_lines(buf, lines, "Local", refs.local_branches, current)
		else
			table.insert(lines, "Local")
			table.insert(lines, "  No local branches")
		end

		if #refs.remote_branches > 0 then
			table.insert(lines, "")
			add_branch_lines(buf, lines, "Remote", refs.remote_branches, current)
		end
	end

	vim.bo[buf].modifiable = true
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].modifiable = false

	vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

	for i, line in ipairs(lines) do
		if line == "Local" or line == "Remote" then
			vim.api.nvim_buf_add_highlight(buf, ns, "GitBranchWorkspaceHeader", i - 1, 0, -1)
		end
	end

	for line_number, branch in pairs(state.branches[buf]) do
		if branch.kind == "local" and branch.name == current then
			vim.api.nvim_buf_add_highlight(buf, ns, "GitBranchWorkspaceCurrent", line_number - 1, 0, -1)
		end
	end
end

local function refresh()
	local workspace = current_workspace()

	if workspace == nil or workspace.branch_buf == nil or not vim.api.nvim_buf_is_valid(workspace.branch_buf) then
		return
	end

	set_branch_lines(workspace.branch_buf)
end

local function close_workspace(tab)
	if tab == nil or not vim.api.nvim_tabpage_is_valid(tab) then
		return
	end

	if vim.api.nvim_get_current_tabpage() ~= tab then
		vim.api.nvim_set_current_tabpage(tab)
	end

	local workspace = state.tabs[tab_key(tab)]

	if workspace == nil then
		return
	end

	workspace.closing = true
	state.tabs[tab_key(tab)] = nil
	state.branches[workspace.branch_buf] = nil

	if workspace.origin_win ~= nil and vim.api.nvim_win_is_valid(workspace.origin_win) then
		vim.api.nvim_set_current_win(workspace.origin_win)
	end

	if
		workspace.branch_win ~= nil
		and vim.api.nvim_win_is_valid(workspace.branch_win)
		and #vim.api.nvim_tabpage_list_wins(tab) > 1
	then
		pcall(vim.api.nvim_win_close, workspace.branch_win, true)
	end

	if workspace.branch_buf ~= nil and vim.api.nvim_buf_is_valid(workspace.branch_buf) then
		pcall(vim.api.nvim_buf_delete, workspace.branch_buf, { force = true })
	end

	if workspace.augroup ~= nil then
		pcall(vim.api.nvim_del_augroup_by_id, workspace.augroup)
	end
end

local function branch_under_cursor()
	local buf = vim.api.nvim_get_current_buf()
	local line_number = vim.api.nvim_win_get_cursor(0)[1]

	return state.branches[buf] and state.branches[buf][line_number]
end

local function switch_branch()
	local workspace = current_workspace()

	if workspace == nil then
		return
	end

	local branch = branch_under_cursor()
	local current = current_branch()

	if branch == nil then
		return
	end

	if branch.kind == "local" and branch.name == current then
		return
	end

	if branch.kind == "remote" and branch.remote_branch == current then
		return
	end

	local args

	if branch.kind == "remote" then
		local local_names, err = local_branch_names()

		if local_names == nil then
			notify(err, vim.log.levels.ERROR)
			return
		end

		if branch.remote_branch == nil then
			notify("Unable to parse remote branch " .. branch.name, vim.log.levels.ERROR)
			return
		end

		if local_names[branch.remote_branch] then
			args = "switch " .. vim.fn.shellescape(branch.remote_branch)
		else
			args = "switch --track " .. vim.fn.shellescape(branch.name)
		end
	else
		args = "switch " .. vim.fn.shellescape(branch.name)
	end

	local output, code = git_run(args)

	if code ~= 0 then
		notify(table.concat(output, "\n"), vim.log.levels.ERROR)
		return
	end

	set_branch_lines(workspace.branch_buf)
	notify("Switched to " .. (branch.remote_branch or branch.name))
end

local function delete_branch()
	local workspace = current_workspace()

	if workspace == nil then
		return
	end

	local branch = branch_under_cursor()

	if branch == nil then
		return
	end

	if branch.kind == "remote" then
		notify("Remote branch deletion is not enabled", vim.log.levels.WARN)
		return
	end

	if branch.name == current_branch() then
		notify("Cannot delete the current branch", vim.log.levels.ERROR)
		return
	end

	local choice = vim.fn.confirm("Delete branch '" .. branch.name .. "'?", "&Delete\n&Cancel", 2, "Warning")

	if choice ~= 1 then
		return
	end

	local output, code = git_run("branch -d " .. vim.fn.shellescape(branch.name))

	if code ~= 0 then
		notify(table.concat(output, "\n"), vim.log.levels.ERROR)
		return
	end

	set_branch_lines(workspace.branch_buf)
	notify("Deleted " .. branch.name)
end

local function copy_branch_name()
	local branch = branch_under_cursor()

	if branch == nil then
		return
	end

	vim.fn.setreg("+", branch.name)
	vim.fn.setreg('"', branch.name)
	print("Copied " .. branch.name)
end

local function search_branch_buffer()
	local ok, builtin = pcall(require, "telescope.builtin")

	if not ok then
		local slash = vim.api.nvim_replace_termcodes("/", true, false, true)
		vim.api.nvim_feedkeys(slash, "n", false)
		return
	end

	local opts = {
		prompt_title = "Branches",
		previewer = false,
	}
	local theme_ok, themes = pcall(require, "telescope.themes")

	if theme_ok then
		opts = themes.get_ivy(opts)
	end

	builtin.current_buffer_fuzzy_find(opts)
end

local function setup_branch_buffer(buf)
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].modifiable = false
	vim.bo[buf].swapfile = false
	vim.bo[buf].filetype = "gitbranchworkspace"

	vim.keymap.set("n", "<CR>", switch_branch, {
		buffer = buf,
		silent = true,
		desc = "Switch to branch",
	})

	vim.keymap.set("n", "<Tab>", switch_branch, {
		buffer = buf,
		silent = true,
		desc = "Switch to branch",
	})

	vim.keymap.set("n", "D", delete_branch, {
		buffer = buf,
		silent = true,
		desc = "Delete branch",
	})

	vim.keymap.set("n", "cc", copy_branch_name, {
		buffer = buf,
		silent = true,
		desc = "Copy branch name",
	})

	vim.keymap.set("n", "r", refresh, {
		buffer = buf,
		silent = true,
		desc = "Refresh branches",
	})

	vim.keymap.set("n", "<leader>s", search_branch_buffer, {
		buffer = buf,
		silent = true,
		desc = "Search branches",
	})

	vim.keymap.set("n", "q", function()
		close_workspace(vim.api.nvim_get_current_tabpage())
	end, {
		buffer = buf,
		silent = true,
		desc = "Close git branch sidebar",
	})
end

function M.open()
	setup_highlights()

	local tab = vim.api.nvim_get_current_tabpage()
	local existing = state.tabs[tab_key(tab)]

	if existing ~= nil and existing.branch_win ~= nil and vim.api.nvim_win_is_valid(existing.branch_win) then
		vim.api.nvim_set_current_win(existing.branch_win)
		return
	end

	local root = git_root()

	if root == nil then
		notify("Not inside a git repository", vim.log.levels.ERROR)
		return
	end

	local origin_win = vim.api.nvim_get_current_win()
	local augroup = vim.api.nvim_create_augroup("GitBranchWorkspace" .. tab, { clear = true })

	vim.cmd("topleft 34vnew")

	local branch_win = vim.api.nvim_get_current_win()
	local branch_buf = vim.api.nvim_create_buf(false, true)

	vim.api.nvim_win_set_buf(branch_win, branch_buf)

	vim.wo.number = false
	vim.wo.relativenumber = false
	vim.wo.signcolumn = "no"
	vim.wo.wrap = false
	vim.wo.cursorline = true

	state.tabs[tab_key(tab)] = {
		root = root,
		branch_buf = branch_buf,
		branch_win = branch_win,
		origin_win = origin_win,
		augroup = augroup,
	}

	setup_branch_buffer(branch_buf)
	set_branch_lines(branch_buf)

	vim.api.nvim_create_autocmd("BufWipeout", {
		group = augroup,
		buffer = branch_buf,
		once = true,
		callback = function()
			local workspace = state.tabs[tab_key(tab)]

			state.branches[branch_buf] = nil

			if workspace == nil or workspace.closing then
				return
			end

			vim.schedule(function()
				close_workspace(tab)
			end)
		end,
	})
end

function M.setup()
	setup_highlights()

	vim.api.nvim_create_user_command("GitBranchWorkspace", function()
		M.open()
	end, {
		desc = "Open a git branch sidebar in the current tab",
	})
end

return M
