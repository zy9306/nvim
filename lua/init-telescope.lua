-- telescope
local telescope = require('telescope')

vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader><leader>", "<cmd>lua require('telescope').extensions.frecency.frecency()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<space>fb", ":Telescope file_browser path=%:p:h<CR>", {noremap = true})

telescope.load_extension('fzf')
telescope.load_extension("frecency")
telescope.load_extension("file_browser")

telescope.setup {pickers = {buffers = {ignore_current_buffer = true, sort_mru = true, sort_lastused = true}}}
