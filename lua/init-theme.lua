if vim.o.background == "light" then
	-- Noice
	vim.cmd("highlight NoiceAttr528 guifg=#6a9f34")
	vim.cmd("highlight NotifyINFOIcon guifg=#6a9f34")
	vim.cmd("highlight NotifyINFOTitle guifg=#6a9f34")

	-- Neotest
	vim.cmd("highlight NeotestPassed ctermfg=10 guifg=#4a7f4a")
	vim.cmd("highlight NeotestFailed ctermfg=9 guifg=#b3003a")
	vim.cmd("highlight NeotestRunning ctermfg=11 guifg=#b89f2c")
	vim.cmd("highlight NeotestSkipped ctermfg=14 guifg=#007a7d")
	vim.cmd("highlight NeotestNamespace ctermfg=13 guifg=#7c3fbf")
	vim.cmd("highlight NeotestFocused cterm=bold,underline gui=bold,underline")
	vim.cmd("highlight NeotestFile ctermfg=14 guifg=#007a7d")
	vim.cmd("highlight NeotestDir ctermfg=14 guifg=#007a7d")
	vim.cmd("highlight NeotestIndent ctermfg=248 guifg=#5c5c5c")
	vim.cmd("highlight NeotestExpandMarker ctermfg=248 guifg=#506070")
	vim.cmd("highlight NeotestAdapterName ctermfg=9 guifg=#b3003a")
	vim.cmd("highlight NeotestWinSelect ctermfg=14 gui=bold guifg=#007a7d")
	vim.cmd("highlight NeotestMarked ctermfg=130 gui=bold guifg=#b35b00")
	vim.cmd("highlight NeotestTarget ctermfg=9 guifg=#b3003a")
	vim.cmd("highlight NeotestWatching ctermfg=11 guifg=#b89f2c")
end
