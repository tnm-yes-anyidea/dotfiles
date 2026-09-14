-- ~/.config/nvim/lua/plugins/ui.lua
return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
        require("tokyonight").setup({ style = "moon" })
        vim.cmd.colorscheme("tokyonight-moon")
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
        require("nvim-tree").setup({ view = { width = 30 } })
        end,
    },
}
