-- ~/.config/nvim/lua/plugins/python.lua
--
return {
  -- Python code formatter
  {
    "mhartington/formatter.nvim",
    config = function()
      require("formatter").setup({
        filetype = {
          python = {
            -- Use black formatter
            function()
              return {
                exe = "black",
                args = { "--quiet", "-" },
                stdin = true,
              }
            end,
          },
        },
      })
    end,
  },
}
