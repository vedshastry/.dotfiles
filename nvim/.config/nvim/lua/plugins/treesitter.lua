-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua", "vim", "javascript", "html", "css" },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
