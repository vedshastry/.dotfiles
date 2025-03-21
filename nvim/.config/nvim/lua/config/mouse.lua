-- ~/.config/nvim/lua/config/mouse.lua

local M = {}

function M.setup()
  -- Enable mouse support in all modes
  vim.opt.mouse = "a"
  
  -- Enable clipboard integration with system
  vim.opt.clipboard = "unnamedplus"
  
  -- Make right-click work as context menu (requires popup menu support)
  vim.api.nvim_set_keymap("n", "<RightMouse>", "<cmd>popup mouseselect<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("v", "<RightMouse>", "<cmd>popup mouseselect<CR>", { noremap = true, silent = true })
  
  -- Define custom mouse actions
  local mouse_mappings = {
    n = {
      ["<2-LeftMouse>"] = "Highlight word under cursor",
      ["<C-LeftMouse>"] = "Go to definition",
      ["<C-RightMouse>"] = "Go back",
      ["<S-LeftMouse>"] = "Start visual selection",
    },
    v = {
      ["<LeftMouse>"] = "Extend visual selection",
      ["<S-LeftMouse>"] = "Extend block selection",
    },
  }
  
  -- Set up right-click context menu options
  vim.cmd([[
    menu mouseselect.File.New :enew<CR>
    menu mouseselect.File.Open :Telescope find_files<CR>
    menu mouseselect.File.Save :w<CR>
    menu mouseselect.File.Close :bd<CR>
    menu mouseselect.-sep1- :
    menu mouseselect.Edit.Copy "+y
    menu mouseselect.Edit.Cut "+d
    menu mouseselect.Edit.Paste "+p
    menu mouseselect.-sep2- :
    menu mouseselect.Code.Format :lua vim.lsp.buf.format()<CR>
    menu mouseselect.Code.Rename :lua vim.lsp.buf.rename()<CR>
    menu mouseselect.Code.CodeAction :lua vim.lsp.buf.code_action()<CR>
    menu mouseselect.Code.FindReferences :lua vim.lsp.buf.references()<CR>
    menu mouseselect.-sep3- :
    menu mouseselect.Tools.Telescope :Telescope<CR>
    menu mouseselect.Tools.Neotree :Neotree focus<CR>
  ]])
  
  -- Set up additional mouse behavior tweaks
  vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
      vim.opt.mousemodel = "popup_setpos"  -- Right-click sets position before showing popup
    end
  })
  
  -- Create visual block mode with shift+mouse drag
  vim.api.nvim_set_keymap("n", "<S-LeftMouse>", "<LeftMouse><Cmd>set mouse-=a<CR><C-v>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<S-LeftDrag>", "<LeftDrag>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<S-LeftRelease>", "<LeftRelease><Cmd>set mouse+=a<CR>", { noremap = true, silent = true })
  
  -- Scroll wheel behavior
  vim.opt.scrolloff = 5  -- Keep at least 5 lines above/below cursor
  vim.opt.sidescrolloff = 5  -- Keep at least 5 columns left/right of cursor
end

return M
