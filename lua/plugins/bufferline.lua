return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        event = "BufReadPre",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("bufferline").setup({
                options = {
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                    diagnostics = "nvim_lsp",
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            text_align = "left",
                            separator = true,
                        },
                    },
                },
            })
        end,
    },
    -- {
    --     "willothy/nvim-cokeline",
    --     event = "BufReadPre",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "nvim-tree/nvim-web-devicons",
    --     },
    --     config = function()
    --         require("cokeline").setup({
    --             buffers = {
    --                 new_buffers_position = "next",
    --             },
    --             default_hl = {
    --                 bold = function(buffer)
    --                     return buffer.is_focused
    --                 end,
    --                 italic = function(buffer)
    --                     return buffer.is_focused
    --                 end,
    --             },
    --         })
    --     end,
    -- },
}
