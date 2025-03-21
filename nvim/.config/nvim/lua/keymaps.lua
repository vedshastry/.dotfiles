-- keymaps.lua

-- General Vim mappings
-- Redo with Ctrl+R in normal mode
vim.keymap.set('n', '<C-r>', '<C-r>', {desc = "Redo"})
-- Find with Ctrl+F
vim.keymap.set('n', '<C-f>', '/', {desc = "find"})

-- Telescope file browser
vim.keymap.set('n', '<C-o>', function()
  require('telescope.builtin').find_files()
end, {desc = "Open file with Telescope"})

-- Unset replace
vim.keymap.set('v', 'r', '', {desc = "replace_unset"})
vim.keymap.set('n', '<Leader>rx', ':Lazy reload xstata-nvim<CR>', {desc = "reloadxstata"})
