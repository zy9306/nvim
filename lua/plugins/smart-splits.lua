return {
    {
        "mrjones2014/smart-splits.nvim",
        config = function()
            vim.keymap.set("n", "<C-S-h>", require("smart-splits").move_cursor_left)
            vim.keymap.set("n", "<C-S-j>", require("smart-splits").move_cursor_down)
            vim.keymap.set("n", "<C-S-k>", require("smart-splits").move_cursor_up)
            vim.keymap.set("n", "<C-S-l>", require("smart-splits").move_cursor_right)

            vim.keymap.set("t", "<C-S-h>", require("smart-splits").move_cursor_left)
            vim.keymap.set("t", "<C-S-j>", require("smart-splits").move_cursor_down)
            vim.keymap.set("t", "<C-S-k>", require("smart-splits").move_cursor_up)
            vim.keymap.set("t", "<C-S-l>", require("smart-splits").move_cursor_right)
        end,
    },
}
