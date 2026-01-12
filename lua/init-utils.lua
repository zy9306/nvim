function find_project_root(patterns)
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

    vim.keymap.set(
        "n",
        "<leader>yP",
        ":lua copy_current_file_path()<CR>",
        { noremap = true, silent = true, desc = "copy full path" }
    )
    vim.keymap.set(
        "n",
        "<leader>yp",
        ":lua copy_current_file_relative_path()<CR>",
        { noremap = true, silent = true, desc = "copy relative path" }
    )
    vim.keymap.set(
        "n",
        "<leader>yf",
        ":lua copy_current_file_name()<CR>",
        { noremap = true, silent = true, desc = "copy file name" }
    )
end

do
    vim.api.nvim_create_user_command("Bdothers", function()
		pcall(vim.cmd, "%bd|e#|bd#")
    end, {})
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
end

do
    vim.api.nvim_create_user_command("ToggleWrap", function()
        vim.wo.wrap = not vim.wo.wrap
        if vim.wo.wrap then
            print("Wrap enabled")
        else
            print("Wrap disabled")
        end
    end, {})

    vim.keymap.set("n", "<leader>$", ":ToggleWrap<CR>", { noremap = true, silent = true, desc = "toggle wrap" })
end

function get_pytest_path()
    local ts_utils = require("nvim-treesitter.ts_utils")
    local parser = vim.treesitter.get_parser(0, "python")
    local tree = parser:parse()[1]
    local root = tree:root()

    local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))

    local node_at_point = ts_utils.get_node_at_cursor()
    while node_at_point ~= nil and node_at_point:type() ~= "function_definition" do
        node_at_point = node_at_point:parent()
    end

    if node_at_point then
        local function_name_node = node_at_point:field("name")[1]
        local function_name = vim.treesitter.get_node_text(function_name_node, 0)

        local filepath = vim.api.nvim_buf_get_name(0)
        local project_root = vim.loop.cwd()
        local relative_path = vim.fn.fnamemodify(filepath, ":." .. project_root .. ":.")

        if function_name:match("^test_") then
            local pytest_path = string.format("%s::%s", relative_path, function_name)
            print(pytest_path)
            vim.fn.setreg("+", pytest_path)
            return pytest_path
        else
            print("No test function found under the cursor.")
            return nil
        end
    else
        print("No function found at the current cursor position.")
        return nil
    end
end

vim.api.nvim_create_user_command("Pytestpath", get_pytest_path, {})

-- golang unit test
function get_go_test_path()
    local parser = vim.treesitter.get_parser(0, "go")
    local tree = parser:parse()[1]
    local root = tree:root()

    local node_at_point = require("nvim-treesitter.ts_utils").get_node_at_cursor()
    while node_at_point ~= nil and node_at_point:type() ~= "function_declaration" do
        node_at_point = node_at_point:parent()
    end

    if node_at_point then
        local function_name_node = node_at_point:child(1)
        local function_name = vim.treesitter.get_node_text(function_name_node, 0)

        if function_name:match("^Test") then
            local filepath = vim.fn.expand("%:p")
            local project_root = vim.loop.cwd()
            local relative_path = filepath:sub(#project_root + 2)
            local relative_dir = vim.fn.fnamemodify(relative_path, ":h")

            local go_test_cmd = string.format("go test -v ./%s -test.run='^\\Q%s\\E$'", relative_dir, function_name)
            print(go_test_cmd)
            vim.fn.setreg("+", go_test_cmd)
            return go_test_cmd
        else
            print("No test function found under the cursor.")
            return nil
        end
    else
        print("No function found at the current cursor position.")
        return nil
    end
end

vim.api.nvim_create_user_command("Gotestpath", get_go_test_path, {})

-- Exit insert mode when entering a window
function exit_insert_mode()
    if vim.fn.mode() == "i" then
        vim.cmd("stopinsert")
    end
end

vim.api.nvim_create_autocmd("WinEnter", {
    callback = exit_insert_mode,
    desc = "Exit insert mode when entering a window if it's in insert mode",
})
