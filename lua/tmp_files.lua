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
        return lines
    end

    return { string.format("[failed to read %s]", path) }
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

    local lines = {}
    for file_index, path in ipairs(files) do
        if file_index > 1 then
            table.insert(lines, "")
        end

        table.insert(lines, string.format("===== %s =====", vim.fn.fnamemodify(path, ":t")))
        table.insert(lines, "")

        vim.list_extend(lines, read_tmp_file(path))
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
end

function M.setup()
    vim.api.nvim_create_user_command("TmpNew", M.new, { desc = "Open a new tmp file" })
    vim.api.nvim_create_user_command("TmpJoin", M.join, { desc = "Join tmp files into a buffer view" })
end

return M
