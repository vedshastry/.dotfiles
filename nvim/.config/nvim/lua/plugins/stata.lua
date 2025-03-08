-- ~/.config/nvim/lua/plugins/stata.lua
return {
  -- Stata syntax highlighting and editing features
  {
    "poliquin/stata-vim",
    ft = {"stata"},
  },

  -- Modified Stata plugin configuration
  {
    'human-d3v/stata-nvim',
    branch = 'packaging',
    ft = {'stata'},
    enabled = false,  -- Temporarily disable this plugin completely
    build = 'git pull origin packaging && cd lsp-server && npm init -y && npm install && bun build ./server/src/server.ts --compile --outfile server_bin && cd ..',
    opts = {},
    config = function ()
     require("stata-nvim")
    end,
    event = 'VeryLazy',
  }
}
