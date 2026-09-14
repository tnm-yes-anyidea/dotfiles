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
}
