local start_time = vim.loop.hrtime()

vim.o.updatetime = 500

vim.opt.swapfile = false

vim.o.autoread = true

vim.o.background = "dark"

vim.o.laststatus = 3

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

vim.g.mapleader = " "
vim.o.timeout = false

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
-- vim.o.mouse = ""
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.wrap = false
vim.o.encoding = "utf-8"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.cursorline = true

vim.opt.clipboard:prepend({ "unnamedplus" })

vim.opt.autoread = true

-- 弹出菜单最多可以显示多少行
vim.o.pumheight = 15

-- 设置弹出菜单的透明度
vim.o.pumblend = 15

-- 设置浮动窗口的透明度
vim.o.winblend = 15

vim.o.showtabline = 1
vim.opt.sessionoptions = "globals,buffers,terminal,blank,curdir,folds,help,tabpages,winsize,winpos,localoptions"

vim.opt.conceallevel = 0

if vim.g.vscode then
    require("init-vscode")
else
    require("config.lazy")
    require("init-telescope")
    require("init-backup")
    require("init-utils")

    require("init-neovide")

    -- require("init-theme")

    require("init-keymap")

    require("init-wezterm")
end

local end_time = vim.loop.hrtime()
local elapsed_time = (end_time - start_time) / 1e6
print(string.format("startup time: %.2f ms", elapsed_time))
