return {
    {
        "stevearc/oil.nvim",
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "oil",
                callback = function(args)
                    vim.keymap.set("n", "<C-c>", "<Esc>", { buffer = args.buf, noremap = true, silent = true })
                    vim.keymap.set("i", "<C-c>", "<Esc>", { buffer = args.buf, noremap = true, silent = true })
                end,
            })

            require("oil").setup({
                delete_to_trash = true,
                view_options = {
                    show_hidden = true,
                },
                keymaps = {
                    ["q"] = { "actions.close", mode = "n" },
                    ["<C-p>"] = {
                        callback = function()
                            local oil = require("oil")
                            local util = require("oil.util")
                            local entry = oil.get_cursor_entry()
                            if not entry then
                                vim.notify("Could not find entry under cursor", vim.log.levels.ERROR)
                                return
                            end
                            local winid = util.get_preview_win()
                            if winid then
                                local cur_id = vim.w[winid].oil_entry_id
                                if entry.id == cur_id then
                                    vim.api.nvim_win_close(winid, true)
                                    if util.is_floating_win() then
                                        local layout = require("oil.layout")
                                        local win_opts = layout.get_fullscreen_win_opts()
                                        vim.api.nvim_win_set_config(0, win_opts)
                                    end
                                    return
                                end
                            end
                            oil.open_preview({ vertical = true, split = "botright" })
                        end,
                    },
                    ["gd"] = {
                        desc = "Toggle file detail view",
                        callback = function()
                            detail = not detail
                            if detail then
                                require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
                            else
                                require("oil").set_columns({ "icon" })
                            end
                        end,
                    },
                    ["yp"] = {
                        desc = "Copy filepath to system clipboard",
                        callback = function()
                            require("oil.actions").copy_entry_path.callback()
                            vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
                        end,
                    },
                },
            })
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
            vim.keymap.set("n", "<leader>jj", "<CMD>Oil<CR>", { desc = "Open parent directory" })
            vim.keymap.set("n", "<leader>jJ", function()
                require("oil").open(vim.fn.getcwd())
            end, { desc = "Oil current working directory" })
        end,
    },
}
