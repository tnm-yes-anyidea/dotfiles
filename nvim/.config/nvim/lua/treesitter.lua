require("nvim-treesitter.configs").setup({
  -- Explicitly list languages or set auto_install
  ensure_installed = { "lua", "vim", "vimdoc", "javascript", "python", "c", "html" },
  auto_install = true,
  highlight = {
    enable = true,
  },
})
