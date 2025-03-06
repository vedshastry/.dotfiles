-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  -- Core LSP support
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Optional LSP progress UI
      "j-hui/fidget.nvim",
    },
  },
  
  -- Mason for managing LSP servers
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end
  },
  
  -- Bridge between Mason and lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",    -- Lua
          "pyright",   -- Python
          -- Add more language servers as needed
        },
        automatic_installation = true,
      })
      
      -- Basic LSP setup
      local lspconfig = require("lspconfig")
      
      -- Setup lua_ls for Neovim development
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
      
      -- Add more language server configurations as needed
    end,
  },
}
