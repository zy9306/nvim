return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		config = function()
			local conform = require("conform")
			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort", "black" },
					go = { "goimports" },
					rust = { "rustfmt", lsp_format = "fallback" },
					javascript = { "prettierd", "prettier", stop_after_first = true },
					json = { "prettierd", "prettier", stop_after_first = true },
				},
				format_after_save = {
					lsp_format = "fallback",
				},
				-- format_on_save = function(bufnr)
				-- 	-- Disable autoformat on certain filetypes
				-- 	local ignore_filetypes = { "sql", "java", "py" }
				-- 	if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
				-- 		return
				-- 	end
				-- 	-- Disable with a global or buffer-local variable
				-- 	if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				-- 		return
				-- 	end
				-- 	-- Disable autoformat for files in a certain path
				-- 	local bufname = vim.api.nvim_buf_get_name(bufnr)
				-- 	if bufname:match("/node_modules/") then
				-- 		return
				-- 	end
				-- 	-- ...additional logic...
				-- 	return { timeout_ms = 500, lsp_format = "fallback" }
				-- end,
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
			do
				-- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md
				vim.api.nvim_create_user_command("Format", function(args)
					local range = nil
					if args.count ~= -1 then
						local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
						range = {
							start = { args.line1, 0 },
							["end"] = { args.line2, end_line:len() },
						}
					end
					require("conform").format({ async = true, lsp_format = "fallback", range = range })
				end, { range = true })
			end
		end,
	},
}
