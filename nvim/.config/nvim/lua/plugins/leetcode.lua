-- ~/.config/nvim/lua/plugins/leetcode.lua
return {
  "kawre/leetcode.nvim",
  lazy = false, -- Must be loaded on start to capture 'nvim leetcode.nvim'
  build = ":TSUpdate html",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter",
    "rcarriga/nvim-notify",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    arg = "leetcode.nvim", 
    lang = "python3", -- Set your language preference (e.g. "cpp", "python3")
  },
}
