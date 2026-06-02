local M = {}

local defaults = {
    keymaps = {
        vertical = { "<C-w>v", "<C-w><C-v>" },
        horizontal = { "<C-w>s", "<C-w><C-s>" },
    },
    save_modified = true,
    nvim = nil,
}

local config = vim.deepcopy(defaults)

local function tmux_socket()
    local tmux_env = vim.env.TMUX
    if not tmux_env or tmux_env == "" then
        return nil
    end

    return vim.split(tmux_env, ",", { trimempty = true })[1]
end

local function current_file_path()
    if vim.bo.buftype ~= "" then
        return nil
    end

    local file = vim.api.nvim_buf_get_name(0)
    if file == "" then
        return nil
    end

    return file
end

local function notify_error(message)
    message = message or ""
    if message == "" then
        message = "Unknown error"
    end

    vim.notify(message, vim.log.levels.ERROR, { title = "tmux split failed" })
end

local function notify_save_error(message)
    message = message or ""
    if message == "" then
        message = "Unknown error"
    end

    vim.notify(message, vim.log.levels.ERROR, { title = "save failed before tmux split" })
end

local function native_split(horizontal)
    if horizontal then
        vim.cmd("vsplit")
    else
        vim.cmd("split")
    end
end

local function fallback_split(win, horizontal)
    if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_set_current_win(win)
    end

    native_split(horizontal)
end

local function save_modified_file()
    if not config.save_modified or not vim.bo.modified then
        return true
    end

    local ok, err = pcall(vim.cmd, "silent update")
    if not ok then
        notify_save_error(err)
        return false
    end

    return true
end

local function current_file()
    local file = current_file_path()
    if not file then
        return nil, false
    end

    if not save_modified_file() then
        return nil, true
    end

    if vim.fn.filereadable(file) ~= 1 then
        return nil, false
    end

    return file, false
end

local function nvim_command(file, cursor)
    local nvim = config.nvim or (vim.v.progpath ~= "" and vim.v.progpath or "nvim")

    return string.format(
        "%s +'call cursor(%d,%d)' %s",
        vim.fn.shellescape(nvim),
        cursor[1],
        cursor[2] + 1,
        vim.fn.shellescape(file)
    )
end

local function system_error_message(result)
    if not result then
        return ""
    end

    if result.stderr and result.stderr ~= "" then
        return vim.trim(result.stderr)
    end

    if result.stdout and result.stdout ~= "" then
        return vim.trim(result.stdout)
    end

    return ""
end

function M.split(horizontal)
    local win = vim.api.nvim_get_current_win()
    local socket = tmux_socket()
    if not socket then
        native_split(horizontal)
        return
    end

    local file, should_stop = current_file()
    if not file then
        if not should_stop then
            native_split(horizontal)
        end

        return
    end

    local cursor = vim.api.nvim_win_get_cursor(0)
    local args = {
        "tmux",
        "-S",
        socket,
        "split-window",
        horizontal and "-h" or "-v",
        "-c",
        vim.fn.getcwd(0, 0),
        nvim_command(file, cursor),
    }

    local ok, err = pcall(vim.system, args, { text = true }, function(result)
        if result.code == 0 then
            return
        end

        vim.schedule(function()
            notify_error(system_error_message(result))
            fallback_split(win, horizontal)
        end)
    end)

    if not ok then
        notify_error(err)
        fallback_split(win, horizontal)
    end
end

local function set_keymaps(keys, horizontal, desc)
    if keys == false then
        return
    end

    for _, key in ipairs(keys or {}) do
        vim.keymap.set("n", key, function()
            M.split(horizontal)
        end, { desc = desc })
    end
end

function M.setup(opts)
    config = vim.tbl_deep_extend("force", vim.deepcopy(defaults), opts or {})

    set_keymaps(config.keymaps.vertical, true, "Tmux vertical split")
    set_keymaps(config.keymaps.horizontal, false, "Tmux horizontal split")
end

return M
