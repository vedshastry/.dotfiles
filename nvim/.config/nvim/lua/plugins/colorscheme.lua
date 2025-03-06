-- ~/.config/nvim/lua/plugins/colorscheme.lua
return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    -- Optional configuration
    require("tokyonight").setup({
      style = "night",
      transparent = false,
    })
  end,
}
