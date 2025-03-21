-- ~/.config/nvim/lua/projects.lua

local M = {}

-- Path to projects file
local projects_file = vim.fn.stdpath("data") .. "/projects.json"

-- Initialize projects list
local projects = {}

-- Load projects from file
local function load_projects()
  local file = io.open(projects_file, "r")
  if file then
    local content = file:read("*all")
    file:close()
    if content and content ~= "" then
      projects = vim.json.decode(content)
    end
  end
  return projects
end

-- Save projects to file
local function save_projects()
  local file = io.open(projects_file, "w")
  if file then
    file:write(vim.json.encode(projects))
    file:close()
  end
end

-- Add a project
function M.add_project(path)
  local projects = load_projects()
  -- Check if project already exists
  for _, project in ipairs(projects) do
    if project.path == path then
      return
    end
  end
  -- Add the project
  table.insert(projects, {
    name = vim.fn.fnamemodify(path, ":t"),
    path = path,
    added = os.time()
  })
  save_projects()
end

-- Remove a project
function M.remove_project(path)
  local projects = load_projects()
  for i, project in ipairs(projects) do
    if project.path == path then
      table.remove(projects, i)
      save_projects()
      return
    end
  end
end

-- Get all projects
function M.get_projects()
  return load_projects()
end

-- Open project selector
function M.select_project()
  local projects = load_projects()
  
  if #projects == 0 then
    vim.notify("No projects found. Add a project first.", vim.log.levels.INFO)
    return
  end
  
  -- Define the items for the picker
  local items = {}
  for _, project in ipairs(projects) do
    table.insert(items, {
      name = project.name,
      path = project.path
    })
  end

  -- Show projects picker
  vim.ui.select(items, {
    prompt = "Select project:",
    format_item = function(item)
      return item.name .. " (" .. item.path .. ")"
    end
  }, function(choice)
    if choice then
      -- Change directory to the selected project
      vim.cmd("cd " .. vim.fn.fnameescape(choice.path))
      -- Open Neo-tree
      vim.cmd("Neotree focus")
      vim.notify("Switched to project: " .. choice.name, vim.log.levels.INFO)
    end
  end)
end

-- Setup command for project management
function M.setup()
  -- Create user commands
  vim.api.nvim_create_user_command("ProjectAdd", function()
    local path = vim.fn.getcwd()
    M.add_project(path)
    vim.notify("Added current directory to projects", vim.log.levels.INFO)
  end, {})
  
  vim.api.nvim_create_user_command("ProjectSelect", function()
    M.select_project()
  end, {})
  
  vim.api.nvim_create_user_command("ProjectRemove", function()
    local path = vim.fn.getcwd()
    M.remove_project(path)
    vim.notify("Removed current directory from projects", vim.log.levels.INFO)
  end, {})
  
  -- Set keymaps
  vim.keymap.set("n", "<leader>pp", M.select_project, { silent = true, desc = "Select Project" })
  vim.keymap.set("n", "<leader>pa", ":ProjectAdd<CR>", { silent = true, desc = "Add Project" })
  vim.keymap.set("n", "<leader>pr", ":ProjectRemove<CR>", { silent = true, desc = "Remove Project" })
end

return M
