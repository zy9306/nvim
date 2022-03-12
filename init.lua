vim.cmd [[packadd packer.nvim]]

local use = require('packer').use

require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'nvim-treesitter/nvim-treesitter'
  use {'romgrk/nvim-treesitter-context', requires = {'nvim-treesitter/nvim-treesitter'}}

  use 'sainnhe/edge'
  use {'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true}}

  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/plenary.nvim'}}}
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use {"nvim-telescope/telescope-frecency.nvim", requires = {"tami5/sqlite.lua"}}
  use 'nvim-telescope/telescope-file-browser.nvim'

  use 'lewis6991/gitsigns.nvim'

  use 'windwp/nvim-autopairs'
  use 'mg979/vim-visual-multi'
  use 'tpope/vim-surround'
  use "folke/which-key.nvim"

  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'
  use 'williamboman/nvim-lsp-installer'
  use 'sbdchd/neoformat'
  use 'jose-elias-alvarez/null-ls.nvim'

  use 'vim-test/vim-test'

  use 'airblade/vim-rooter'

  use 'mhinz/vim-startify'

  use 'jdhao/better-escape.vim'
  use 'arthurxavierx/vim-caser'
end)

vim.g.mapleader = ";"

require('nvim-autopairs').setup {}

require('init-lsp')
require('init-git')
require('init-lualine')
require('init-telescope')

-- treesitter
local treesitter = require 'nvim-treesitter.configs'
treesitter.setup {highlight = {enable = true}}

-- opt
vim.opt.nu = true
vim.opt.mouse = 'a'
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.wrap = false
vim.opt.encoding = 'utf-8'
vim.opt.clipboard:prepend{"unnamedplus"}

-- theme
if vim.fn.has('termguicolors') == 1 then vim.g.termguicolors = true end

vim.g.edge_style = 'edge'
vim.g.edge_enable_italic = 0
vim.g.edge_disable_italic_comment = 0

vim.cmd([[
set bg=light
syntax on
set notimeout
colorscheme edge
]])

vim.cmd([[
noremap <C-X><C-S> :update<CR>
noremap <C-X>c :qa!<CR>
noremap <C-X>s :wa<CR>

inoremap <C-X><C-S> <Esc>:update<CR>
inoremap <C-X>c :qa!<CR>
inoremap <C-X>s :wa<CR>

inoremap <C-B> <Left>
inoremap <C-F> <Right>
]])

-- escape
vim.g.better_escape_shortcut = 'jj'
vim.g.better_escape_interval = 200
