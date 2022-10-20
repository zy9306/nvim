-- telescope
local telescope = require('telescope')

vim.api.nvim_set_keymap("n", "<leader>tf", "<cmd>lua require('telescope.builtin').find_files()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>tF", ":Telescope file_browser path=%:p:h<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>tb", "<cmd>lua require('telescope.builtin').buffers()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>ts", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>lua require('telescope.builtin').treesitter()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>tx", "<cmd>lua require('telescope.builtin').commands()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>th", "<cmd>lua require('telescope.builtin').help_tags()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader><leader>", "<cmd>lua require('telescope').extensions.frecency.frecency()<cr>",
                        {noremap = true, silent = true})

telescope.load_extension('fzf')
telescope.load_extension("frecency")
telescope.load_extension("file_browser")

telescope.setup {pickers = {buffers = {ignore_current_buffer = true, sort_mru = true, sort_lastused = true}}}
