return {
	{
		"nanozuki/tabby.nvim",
		config = function()
			local theme = {
				current = { fg = "#000000", bg = "transparent", style = "bold" },
				not_current = { fg = "#808080", bg = "transparent", style = "bold" },
			}
			require("tabby").setup({
				line = function(line)
					return {
						{ { " " } },
						line.tabs().foreach(function(tab)
							local hl = tab.is_current() and theme.current or theme.not_current
							return {
								tab.is_current() and "" or "󰆣",
								tab.number(),
								tab.name(),
								tab.close_btn(""),
								{ " " },
								hl = hl,
								margin = " ",
							}
						end),
					}
				end,
			})
		end,
	},
	{
		"tiagovla/scope.nvim",
		config = function()
			require("scope").setup({})
		end,
	},
}
