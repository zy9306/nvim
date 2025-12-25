return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true,
                    disable = {},
                },
                disable = {},
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "vv",
                        node_incremental = "vv",
                        node_decremental = "vV",
                    },
                },
            })

            vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
                pattern = "*.j2",
                callback = function()
                    vim.opt.filetype = "jinja"
                end,
            })
        end,
    },

    -- {
    -- 	"nvim-treesitter/nvim-treesitter-context",
    -- 	config = function()
    -- 		require("treesitter-context").setup({
    -- 			enable = true,
    -- 			max_lines = 0,
    -- 			min_window_height = 0,
    -- 			line_numbers = true,
    -- 			multiline_threshold = 20,
    -- 			trim_scope = "outer",
    -- 			mode = "cursor",
    -- 			separator = nil,
    -- 			zindex = 20,
    -- 			on_attach = nil,
    -- 		})
    -- 	end,
    -- },
}
