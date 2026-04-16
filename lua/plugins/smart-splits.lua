return {
    {
        "mrjones2014/smart-splits.nvim",
        config = function()
            local smart_splits = require("smart-splits")
            local moves = {
                h = smart_splits.move_cursor_left,
                j = smart_splits.move_cursor_down,
                k = smart_splits.move_cursor_up,
                l = smart_splits.move_cursor_right,
            }

            for _, mode in ipairs({ "n", "t" }) do
                for key, action in pairs(moves) do
                    vim.keymap.set(mode, string.format("<C-S-%s>", key), action)
                    vim.keymap.set(mode, string.format("<C-x>%s", key), action)
                end
            end
        end,
    },
}
