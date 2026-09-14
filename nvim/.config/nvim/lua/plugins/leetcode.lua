return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",

    -- Optional but recommended for icons and syntax
    "nvim-treesitter/nvim-treesitter",
    "rcarriga/nvim-notify",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    -- Pass leetcode.nvim to start the UI automatically when you run `nvim leetcode.nvim`
    arg = "leetcode.nvim", 
    lang = "python3", -- Change this to your preferred language (e.g., "cpp", "java", "rust")
  },
}

