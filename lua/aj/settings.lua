o = vim.o
wo = vim.wo
opt = vim.opt

vim.cmd [[
set noerrorbells
set noswapfile
set nobackup
set incsearch
set tabstop=2
set softtabstop=2
set shiftwidth=2
set noautochdir
set updatetime=100
set nocompatible
]]

o.relativenumber = true
wo.wrap = false
o.smartcase = true
o.laststatus = 2

o.clipboard = "unnamedplus"


