vim.o.updatetime = 500

vim.o.background = "light"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

vim.g.mapleader = " "
vim.o.timeout = false

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
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

-- vim.o.showtabline = 2
-- vim.opt.sessionoptions = "curdir,folds,globals,help,buffers,tabpages,terminal,winsize"

require("config.lazy")
require("init-telescope")
require("init-toggleterm")
require("init-backup")
require("init-utils")

require("init-neovide")

require("init-theme")

require("init-keymap")
