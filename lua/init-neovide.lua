if vim.g.neovide then
    vim.g.neovide_floating_shadow = false
    vim.g.neovide_input_macos_option_key_is_meta = "only_left"

    vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })

    -- disable animation
    -- vim.g.neovide_position_animation_length = 0
    -- vim.g.neovide_cursor_animation_length = 0.00
    vim.g.neovide_cursor_trail_size = 0
    -- vim.g.neovide_cursor_animate_in_insert_mode = false
    -- vim.g.neovide_cursor_animate_command_line = false
    -- vim.g.neovide_scroll_animation_far_lines = 0
    -- vim.g.neovide_scroll_animation_length = 0.00
end
