-- plugins/quarto.lua
return {
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
-- ~/.config/nvim/lua/plugins/quarto.lua
-- return {
--   "quarto-dev/quarto-nvim",
--     dependencies = {
--         "neovim/nvim-lspconfig",
--             "jmbuhr/otter.nvim",
--               },
--                 config = function()
--                     require("quarto").setup({
--                           -- Your quarto configuration
--                               })
--                                 end,
--                                 }
