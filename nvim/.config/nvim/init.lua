-- ~/.config/nvim/init.lua

----------------------
-- Bootstrap lazy.nvim
----------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader and local leader mapping
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- automatically check for plugin updates
  checker = { enabled = true },
  -- UI
  ui = {
    border = "rounded"
  },
  -- Change detection
  change_detection = {
    notify = true
  },
  -- Dev config
  dev = {
    -- Path where local plugin repos are stored
    path = "~/repos",
    -- Patterns for plugin names that should be considered as local development plugins
    patterns = { "xstata-nvim" },
    -- Don't automatically change any plugins to dev
    fallback = false,
  },
})

--------------------------------------------------------------------

-- Keymaps
require('keymaps')

-- Set up mouse support
require("config.mouse").setup()

-- Initialize projects module
require("projects").setup()

-- Basic options
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.incsearch = true
vim.opt.termguicolors = true

-- Additional options based on your Pulsar config
vim.opt.scrolloff = 5           -- Keep 5 lines above/below cursor
vim.opt.sidescrolloff = 5       -- Keep 5 columns left/right of cursor
vim.opt.showmode = false        -- Don't show mode in command line (statusline shows it)
vim.opt.signcolumn = "no"      -- Always show sign column
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.updatetime = 100        -- Faster completion
vim.opt.timeoutlen = 500        -- Faster key sequence completion
vim.opt.splitright = true       -- Open new vertical splits to the right
vim.opt.splitbelow = true       -- Open new horizontal splits below
vim.opt.ignorecase = true       -- Ignore case in search
vim.opt.smartcase = true        -- Unless uppercase is used
vim.opt.list = true             -- Show invisible characters
vim.opt.listchars = {           -- Define invisible characters display
  tab = "→ ",
  trail = "·",
  extends = "…",
  precedes = "…",
  nbsp = "␣"
}
vim.opt.title = true            -- Set window title
vim.opt.titlestring = "%<%F - nvim" -- Format for window title

-- Auto commands
local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Resize splits on window resize
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Go to last location when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto-format on save (if formatter is available)
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("auto_format"),
  callback = function()
    if vim.fn.exists(":Format") > 0 then
      vim.cmd("Format")
    end
  end,
})

-- Help for keymaps
vim.api.nvim_create_user_command("Keys", function()
  vim.cmd("help keymaps.txt")
end, {})

-- Show if in a git repository
vim.api.nvim_create_user_command("GitRepo", function()
  local handle = io.popen("git rev-parse --is-inside-work-tree 2>/dev/null")
  if handle then
    local result = handle:read("*a")
    handle:close()
    if result:match("true") then
      vim.notify("Currently in a git repository", vim.log.levels.INFO)
    else
      vim.notify("Not in a git repository", vim.log.levels.WARN)
    end
  end
end, {})
