-- ~/.config/nvim/lua/plugins/xstata-nvim.lua
--
return {
  -- Syntax highlighting for Stata files
  {
    "poliquin/stata-vim",  
    ft = { "stata", "do", "ado", "mata" },
  },

  -- Stata integration with improvements
  {
    "vedshastry/xstata-nvim",
    lazy = true,
    ft = { "stata", "do", "ado", "mata" },
    dependencies = {
      "poliquin/stata-vim",
    },
    config = function()
      require("xstata-nvim").setup({
        which_app = "StataMP",  -- Change to StataMP, StataSE, or other as needed
        advance_position = false,
        skip_comments = true,
        focus_window = true,
        paste_speed = 1.0,
        -- Additional settings for enhanced experience
        auto_format = true,      -- Automatically format code
        show_line_numbers = true, -- Show line numbers in Stata's do-file editor
      })
    end,
  },
  
}
