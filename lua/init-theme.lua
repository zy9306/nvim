do
    local original_highlights = {}

    function save_original_highlights()
        local highlights = {
            "NoiceAttr528",
            "NotifyINFOIcon",
            "NotifyINFOTitle",

            "NeotestPassed",
            "NeotestFailed",
            "NeotestRunning",
            "NeotestSkipped",
            "NeotestNamespace",
            "NeotestFocused",
            "NeotestFile",
            "NeotestDir",
            "NeotestIndent",
            "NeotestExpandMarker",
            "NeotestAdapterName",
            "NeotestWinSelect",
            "NeotestMarked",
            "NeotestTarget",
            "NeotestWatching",
        }

        for _, group in ipairs(highlights) do
            local success, definition = pcall(vim.api.nvim_exec, "highlight " .. group, true)
            if success then
                original_highlights[group] = definition
            end
        end
    end

    function restore_original_highlights()
        for group, definition in pairs(original_highlights) do
            vim.cmd("highlight " .. definition)
        end
    end

    save_original_highlights()
end

function adjust_light_highlight()
    if vim.o.background == "light" then
        -- Noice
        vim.cmd("highlight NoiceAttr528 guifg=#6a9f34")
        vim.cmd("highlight NotifyINFOIcon guifg=#6a9f34")
        vim.cmd("highlight NotifyINFOTitle guifg=#6a9f34")

        -- Neotest
        vim.cmd("highlight NeotestPassed ctermfg=10 guifg=#4a7f4a")
        vim.cmd("highlight NeotestFailed ctermfg=9 guifg=#b3003a")
        vim.cmd("highlight NeotestRunning ctermfg=11 guifg=#b89f2c")
        vim.cmd("highlight NeotestSkipped ctermfg=14 guifg=#007a7d")
        vim.cmd("highlight NeotestNamespace ctermfg=13 guifg=#7c3fbf")
        vim.cmd("highlight NeotestFocused cterm=bold,underline gui=bold,underline")
        vim.cmd("highlight NeotestFile ctermfg=14 guifg=#007a7d")
        vim.cmd("highlight NeotestDir ctermfg=14 guifg=#007a7d")
        vim.cmd("highlight NeotestIndent ctermfg=248 guifg=#5c5c5c")
        vim.cmd("highlight NeotestExpandMarker ctermfg=248 guifg=#506070")
        vim.cmd("highlight NeotestAdapterName ctermfg=9 guifg=#b3003a")
        vim.cmd("highlight NeotestWinSelect ctermfg=14 gui=bold guifg=#007a7d")
        vim.cmd("highlight NeotestMarked ctermfg=130 gui=bold guifg=#b35b00")
        vim.cmd("highlight NeotestTarget ctermfg=9 guifg=#b3003a")
        vim.cmd("highlight NeotestWatching ctermfg=11 guifg=#b89f2c")
    end
end

adjust_light_highlight()

do
    local start_time = os.clock()
    local theme_file = vim.fn.stdpath("config") .. "/data/theme.txt"

    local function load_theme()
        local file = io.open(theme_file, "r")
        if file then
            local theme = file:read("*l")
            file:close()
            if theme == "light" or theme == "dark" then
                vim.o.background = theme
            end
        end
    end

    local function save_theme(theme)
        local file = io.open(theme_file, "w")
        if file then
            file:write(theme)
            file:close()
        end
    end

    function toggle_theme()
        local current_background = vim.o.background
        if current_background == "dark" then
            vim.o.background = "light"
            adjust_light_highlight()
        else
            vim.o.background = "dark"
            restore_original_highlights()
        end
        save_theme(vim.o.background)
    end

    vim.api.nvim_create_user_command("ToggleTheme", toggle_theme, { desc = "Toggle between light and dark theme" })

    load_theme()
    local end_time = os.clock()
    local elapsed_time = end_time - start_time

    -- print(string.format("load theme cost: %.6fs", elapsed_time))
end
