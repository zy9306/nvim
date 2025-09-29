return {
    {
        "stevearc/conform.nvim",
        lazy = false,
        config = function()
            local conform = require("conform")
            vim.b.disable_autoformat = true
            vim.g.disable_autoformat = true
            conform.setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "isort", "black" },
                    go = { "goimports" },
                    rust = { "rustfmt", lsp_format = "fallback" },
                    javascript = { "prettierd", "prettier", stop_after_first = true },
                    typescript = { "prettierd", "prettier", stop_after_first = true },
                    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
                    svelte = { "prettierd", "prettier", stop_after_first = true },
                    html = { "prettierd", "prettier", stop_after_first = true },
                    css = { "prettierd", "prettier", stop_after_first = true },
                    json = { "prettierd", "prettier", stop_after_first = true },
                    sh = { "shfmt" },
                },

                format_after_save = function(bufnr)
                    local bufname = vim.api.nvim_buf_get_name(bufnr)
                    local patterns = { "proto" }

                    for _, pattern in ipairs(patterns) do
                        if bufname:match(pattern) then
                            return
                        end
                    end
                    return { lsp_format = "fallback" }
                end,
            })

            conform.formatters.shfmt = {
                prepend_args = function(self, ctx)
                    return { "-i", "2" }
                end,
            }

            conform.formatters.stylua = {
                prepend_args = function(self, ctx)
                    return { "--config-path", vim.fn.stdpath("config") .. "/stylua.toml" }
                end,
            }

            conform.setup({
                format_on_save = function(bufnr)
                    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                        return
                    end
                    return {}
                end,
            })

            vim.api.nvim_create_user_command("FormatDisable", function(args)
                if args.bang then
                    vim.b.disable_autoformat = true
                else
                    vim.g.disable_autoformat = true
                end
            end, {
                desc = "Disable autoformat-on-save",
                bang = true,
            })

            vim.api.nvim_create_user_command("FormatEnable", function()
                vim.b.disable_autoformat = false
                vim.g.disable_autoformat = false
            end, {
                desc = "Re-enable autoformat-on-save",
            })

            vim.api.nvim_create_user_command("Format", function(args)
                local range = nil
                if args.count ~= -1 then
                    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                    range = {
                        start = { args.line1, 0 },
                        ["end"] = { args.line2, end_line:len() },
                    }
                end
                require("conform").format({ async = false, lsp_format = "fallback", range = range })
            end, { range = true })

			vim.keymap.set("n", "<leader>F", ":Format<CR>", { desc = "Format buffer" })

            vim.api.nvim_create_user_command("TrimWhitespace", function()
                require("conform").format({ formatters = { "trim_whitespace" } })
            end, {})
        end,
    },
}
