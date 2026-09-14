-- ~/.config/nvim/lua/plugins/tools.lua
return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    lazy = true,
    keys = {
      { "<C-p>", "<cmd>FzfLua files<CR>", desc = "Find Files" },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
      { "<F7>", "<cmd>LazyGit<CR>", desc = "LazyGit" },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    lazy = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "File Explorer" },
    },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 30,
          adaptive_size = true,
        },
        renderer = {
          group_empty = true,
          icons = {
            git_placement = "before",
          },
        },
        filters = {
          dotfiles = false,
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    build = ":TSUpdate",
    config = function()
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then return end

      configs.setup({
        ensure_installed = { "lua", "vim", "python", "go", "c", "cpp", "javascript", "typescript", "json" },
        highlight = { enable = true },
        sync_install = false,
        indent = { enable = true },
      })
    end,
  },
}
