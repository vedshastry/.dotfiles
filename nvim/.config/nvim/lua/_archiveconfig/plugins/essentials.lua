return {
  { "nvim-lua/plenary.nvim" },
  { "folke/tokyonight.nvim" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
}
