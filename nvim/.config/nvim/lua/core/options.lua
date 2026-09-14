-- ~/.config/nvim/lua/core/options.lua
local opt = vim.opt

opt.number = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.cursorline = true
opt.smartindent = true
opt.history = 100
opt.mouse = "a"
opt.hlsearch = true
opt.termguicolors = true
opt.colorcolumn = "80"
opt.clipboard = "unnamedplus"

vim.cmd("syntax on")
vim.cmd("filetype on")
vim.cmd("filetype indent on")
