local function set_wezterm_tab_name()
    local root = find_project_root({ ".git" })
    if root and root ~= "." then
        local project_name = vim.fn.fnamemodify(root, ":t")
        local tab_title = "📝 " .. project_name
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
        local tab_title = "💲 " .. project_name
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
                                                    'echo "wezterm cli set-tab-title \\"%s\\" && cd %s\n" | wezterm cli send-text --no-paste --pane-id %s',
                                                    tab_title,
                                                    root,
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

-- vim.api.nvim_create_user_command("CreateWeztermTab", function()
--     create_wezterm_tab()
-- end, {})
--
-- vim.api.nvim_create_autocmd("BufEnter", {
--     callback = set_wezterm_tab_name,
-- })
