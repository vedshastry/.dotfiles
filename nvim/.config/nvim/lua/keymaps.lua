-- keymaps.lua

-- Set up Stata keybindings 
-- These will work when editing Stata files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "stata,do",
  callback = function()
    -- Run current line with Ctrl+Enter
    vim.keymap.set('n', '<C-CR>', function() require("xstata-nvim").run() end, {buffer = true})
    vim.keymap.set('v', '<C-CR>', function() require("xstata-nvim").run() end, {buffer = true})
    
    -- Run entire file with Ctrl+Shift+D
    vim.keymap.set('n', '<C-S-d>', function() require("xstata-nvim").run_all() end, {buffer = true})
    
    -- Run paragraph (similar functionality to Hydrogen run-and-move-down)
    vim.keymap.set('n', '<C-A-CR>', function() 
      require("xstata-nvim").run_paragraph()
    end, {buffer = true})
  end
})

-- General Vim mappings
-- Redo with Ctrl+R in normal mode
vim.keymap.set('n', '<C-r>', '<C-r>', {desc = "Redo"})
-- Find with Ctrl+F
vim.keymap.set('n', '<C-f>', '/', {desc = "find"})

-- Telescope file browser
vim.keymap.set('n', '<C-o>', function()
  require('telescope.builtin').find_files()
end, {desc = "Open file with Telescope"})

