local bookmarks_file = vim.fn.stdpath("data") .. "/bookmarks.json"
_G.bookmarks = _G.bookmarks or {}

local function save_bookmarks_to_file()
    local file = io.open(bookmarks_file, "w")
    if file then
        file:write(vim.fn.json_encode(_G.bookmarks))
        file:close()
    else
        print("Error: Unable to save bookmarks.")
    end
end

local function load_bookmarks_from_file()
    local file = io.open(bookmarks_file, "r")
    if file then
        local content = file:read("*a")
        _G.bookmarks = vim.fn.json_decode(content) or {}
        file:close()
    else
        print("No bookmarks file found, starting with an empty list.")
    end
end

local function get_project_name()
    local handle = io.popen("git rev-parse --show-toplevel 2>/dev/null")
    local result = handle:read("*a")
    handle:close()
    if result == "" then
        return "default_project"
    else
        return result:match("([^/]+)\n$")
    end
end

function _G.add_bookmark()
    local project_name = get_project_name()
    local line = vim.api.nvim_get_current_line()
    local description = vim.fn.input("Description: ")
    local file_path = vim.fn.expand("%:p")
    local line_number = vim.fn.line(".")
    local project_root = vim.fn.trim(vim.fn.system("git rev-parse --show-toplevel"))
    local relative_path = file_path:sub(#project_root + 2)

    if not _G.bookmarks[project_name] then
        _G.bookmarks[project_name] = {}
    end

    table.insert(_G.bookmarks[project_name], {
        project_name = project_name,
        file_path = file_path,
        relative_path = relative_path,
        line = line,
        line_number = line_number,
        description = description,
    })
    save_bookmarks_to_file()
    print("Bookmark added to project: " .. project_name)
end

function _G.show_bookmarks()
    load_bookmarks_from_file()

    local project_name = get_project_name()
    local all_bookmarks = {}

    local function add_bookmarks(project)
        if _G.bookmarks[project] then
            for i, mark in ipairs(_G.bookmarks[project]) do
                table.insert(all_bookmarks, {
                    display = i
                        .. ": "
                        .. " Project: "
                        .. mark.project_name
                        .. " - "
                        .. mark.relative_path
                        .. " - "
                        .. " Line: "
                        .. mark.line
                        .. " - "
                        .. mark.description,
                    mark = mark,
                })
            end
        end
    end

    add_bookmarks(project_name)

    if project_name ~= "default_project" then
        add_bookmarks("default_project")
    end

    for project, _ in pairs(_G.bookmarks) do
        if project ~= project_name and project ~= "default_project" then
            add_bookmarks(project)
        end
    end

    if #all_bookmarks == 0 then
        print("No bookmarks available.")
        return
    end

    local choices = {}
    for _, item in ipairs(all_bookmarks) do
        table.insert(choices, item.display)
    end

    vim.ui.select(choices, { prompt = "Select a bookmark:" }, function(choice, idx)
        if choice then
            local mark = all_bookmarks[idx].mark
            vim.cmd("edit " .. mark.file_path)
            vim.fn.cursor(mark.line_number, 0)
        else
            print("No bookmark selected.")
        end
    end)
end

vim.api.nvim_create_user_command("AddBookmark", _G.add_bookmark, {})
vim.api.nvim_create_user_command("ShowBookmarks", _G.show_bookmarks, {})
vim.api.nvim_create_user_command("OpenBookmarksFile", function()
    vim.cmd("edit " .. bookmarks_file)
end, {})

return {}
