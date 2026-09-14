-- ~/.config/nvim/init.lua
-- Optimized for faster startup and better performance

-- 1. Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
end
vim.opt.rtp:prepend(lazypath)

-- 2. Set leader before anything else
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 3. Setup Lazy with performance optimizations
require("lazy").setup("plugins", {
  defaults = { lazy = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- 4. Load core settings (after lazy is ready)
require("core.options")
require("core.keybinds")
require("statusline")
