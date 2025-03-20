return
{
  {
  "poliquin/stata-vim",  -- Your syntax highlighting plugin
    ft = { "stata", "do", "ado", "mata" },  -- Load when editing Stata files
  },

  {
    "vedshastry/xstata-nvim",
    lazy = true,  -- Only load when needed
    ft = { "stata", "do", "ado", "mata" },  -- Load when editing Stata files
    dependencies = {
      "poliquin/stata-vim",  -- Your syntax highlighting plugin
    },
    config = function()
      require("xstata-nvim").setup({
        which_app = "StataMP",  -- Change to StataMP, StataSE, or other as needed
        advance_position = false,
        skip_comments = true,
        focus_window = true,
        paste_speed = 1.0,
      })
    end,
    keys = {
      { "<C-CR>", "<cmd>lua require('xstata-nvim').run()<CR>", desc = "Send line/selection to Stata" },
      { "<Leader>rp", "<cmd>lua require('xstata-nvim').run_previous_command()<CR>", desc = "Run previous Stata command" },
      { "<Leader>ra", "<cmd>lua require('xstata-nvim').run_all()<CR>", desc = "Run entire buffer in Stata" },
      { "<Leader>rr", "<cmd>lua require('xstata-nvim').run_paragraph()<CR>", desc = "Run current paragraph in Stata" },
    },
  }

}
