return {
    {
        "notomo/gesture.nvim",
        config = function()
            vim.opt.mouse = "a"
            vim.opt.mousemoveevent = true

            vim.keymap.set("n", "<RightMouse>", [[<Nop>]])
            vim.keymap.set("n", "<RightDrag>", [[<Cmd>lua require("gesture").draw()<CR>]], { silent = true })
            vim.keymap.set("n", "<RightRelease>", [[<Cmd>lua require("gesture").finish()<CR>]], { silent = true })

            local gesture = require("gesture")
            gesture.register({
                name = "scroll to bottom",
                inputs = { gesture.down() },
                action = "normal! G",
            })
            gesture.register({
                name = "scroll to top",
                inputs = { gesture.up() },
                action = "normal! gg",
            })
            gesture.register({
                name = "next tab",
                inputs = { gesture.up(), gesture.right() },
                action = "tabnext",
            })
            gesture.register({
                name = "previous tab",
                inputs = { gesture.up(), gesture.left() },
                action = function(_)
                    vim.cmd.tabprevious()
                end,
            })
            gesture.register({
                name = "go back",
                inputs = { gesture.left() },
                action = function()
                    vim.api.nvim_feedkeys(vim.keycode("<C-o>"), "n", true)
                end,
            })
            gesture.register({
                name = "go forward",
                inputs = { gesture.right() },
                action = function()
                    vim.api.nvim_feedkeys(vim.keycode("<C-i>"), "n", true)
                end,
            })
            gesture.register({
                name = "close window",
                inputs = { gesture.down(), gesture.right() },
                action = function()
                    pcall(vim.api.nvim_win_close, 0, false)
                end,
            })
            gesture.register({
                name = "save file",
                inputs = { gesture.up(), gesture.right(), gesture.down() },
                action = function()
                    vim.cmd.write()
                end,
            })
            gesture.register({
                name = "close gesture traced windows",
                match = function(ctx)
                    local last_input = ctx.inputs[#ctx.inputs]
                    return last_input and last_input.direction == "UP"
                end,
                can_match = function(ctx)
                    local first_input = ctx.inputs[1]
                    return first_input and first_input.direction == "RIGHT"
                end,
                action = function(ctx)
                    table.sort(ctx.window_ids, function(a, b)
                        return a > b
                    end)
                    for _, window_id in ipairs(ctx.window_ids) do
                        if vim.api.nvim_win_is_valid(window_id) then
                            vim.api.nvim_win_close(window_id, false)
                        end
                    end
                end,
            })
        end,
    },
}
