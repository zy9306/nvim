return {
    {
        "aserowy/tmux.nvim",
        config = function()
            require("tmux").setup({
                copy_sync = {
                    redirect_to_clipboard = true,
                },
            })

            -- vim.keymap.set("n", "<C-S-h>", require("tmux").move_left)
            -- vim.keymap.set("n", "<C-S-j>", require("tmux").move_bottom)
            -- vim.keymap.set("n", "<C-S-k>", require("tmux").move_top)
            -- vim.keymap.set("n", "<C-S-l>", require("tmux").move_right)

            -- vim.keymap.set("t", "<C-S-h>", require("tmux").move_left)
            -- vim.keymap.set("t", "<C-S-j>", require("tmux").move_bottom)
            -- vim.keymap.set("t", "<C-S-k>", require("tmux").move_top)
            -- vim.keymap.set("t", "<C-S-l>", require("tmux").move_right)
        end,
    },
}
