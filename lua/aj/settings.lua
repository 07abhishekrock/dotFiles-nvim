local o = vim.o
local wo = vim.wo
local vim = vim
local opt = vim.opt

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.cmd [[
set noerrorbells
set noswapfile
set nobackup
set incsearch
set tabstop=2
set softtabstop=2
set shiftwidth=2
set updatetime=100
set nocompatible
set foldlevelstart=99
]]

o.relativenumber = true
wo.wrap = false
o.smartcase = true
o.laststatus = 2

o.clipboard = "unnamedplus"


