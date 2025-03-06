-- lua/config/autocmds.lua
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end
})

-- Remove whitespace on save
autocmd("BufWritePre", {
  pattern = "*",
  command = ":%s/\\s\\+$//e"
})

-- Don't auto comment new lines
autocmd("BufEnter", {
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o"
})

-- Set indentation for specific file types
autocmd("FileType", {
  pattern = "lua",
  command = "setlocal tabstop=2 shiftwidth=2"
})

return {}
