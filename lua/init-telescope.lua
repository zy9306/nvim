-- telescope
local telescope = require('telescope')

vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua require('telescope.builtin').find_files()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>F", ":Telescope file_browser path=%:p:h<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>s", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>",
                        {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>S", "<cmd>lua require('telescope.builtin').live_grep()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>I", "<cmd>lua require('telescope.builtin').treesitter()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>x", "<cmd>lua require('telescope.builtin').commands()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>H", "<cmd>lua require('telescope.builtin').help_tags()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader><leader>", "<cmd>lua require('telescope').extensions.frecency.frecency()<cr>",
                        {noremap = true, silent = true})

telescope.load_extension('fzf')
telescope.load_extension("frecency")
telescope.load_extension("file_browser")

telescope.setup {pickers = {buffers = {ignore_current_buffer = true, sort_mru = true, sort_lastused = true}}}
