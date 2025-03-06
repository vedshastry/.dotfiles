-- ~/.config/nvim/lua/plugins/init.lua
return {
  -- Import all other plugin files
  require("plugins.colorscheme"),
  require("plugins.treesitter"),
  require("plugins.telescope"),
  require("plugins.quarto"),
  -- Add more plugin imports as you create them
}
