-- ~/.config/nvim/lua/plugins/colorscheme.lua
return {
  "folke/tokyonight.nvim",
  priority = 1000,

    -- Optional configuration
    config = function()
      require("tokyonight").setup(
        {
        style = "night",
        transparent = false,
        }
      )

    -- set theme
    vim.cmd([[colorscheme tokyonight]])

  end,
}
