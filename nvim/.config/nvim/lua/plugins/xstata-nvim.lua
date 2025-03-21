-- ~/.config/nvim/lua/plugins/xstata-nvim.lua
return {
  -- Syntax highlighting for Stata files
  {
    "poliquin/stata-vim",
    ft = { "stata", "do", "ado", "mata" },
  },

  -- Stata integration with improvements
  {
    "vedshastry/xstata-nvim",
    dev = true,  -- using local dev version
    lazy = true,
    ft = { "stata", "do", "ado", "mata" },
    dependencies = {
      "poliquin/stata-vim",
    },
    config = function()
        require('xstata-nvim').setup({
          advance_position = false,
          skip_comments = true,
        })
    end,
  },
}
