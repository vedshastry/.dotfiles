-- ~/.config/nvim/lua/plugins/neo-tree.lua

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- for file icons
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- Unless you are still migrating, remove the deprecated commands
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

    require("neo-tree").setup({
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      
      -- Mouse support
      use_popups_for_input = false, -- If false, inputs will use vim.ui.input() instead of custom popups
      use_default_mappings = true,  -- Default mappings for mouse
      
      default_component_configs = {
        container = {
          enable_character_fade = true
        },
        indent = {
          indent_size = 2,
          padding = 1, -- extra padding on left hand side
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          highlight = "NeoTreeIndentMarker",
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          default = "*",
          highlight = "NeoTreeFileIcon"
        },
        modified = {
          symbol = "[+]",
          highlight = "NeoTreeModified",
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = "NeoTreeFileName",
        },
        git_status = {
          symbols = {
            -- Change type
            added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted   = "✖", -- this can only be used in the git_status source
            renamed   = "󰁕", -- this can only be used in the git_status source
            -- Status type
            untracked = "",
            ignored   = "",
            unstaged  = "󰄱",
            staged    = "",
            conflict  = "",
          }
        },
      },
      
      window = { -- see :h neo-tree-window-configuration
        position = "left",
        width = 30,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          -- Mouse mappings
          ["<2-LeftMouse>"] = "open",
          ["<RightMouse>"] = "open_with_window_picker", -- Alternative: show a context menu
          
          -- Keyboard mappings
          ["<space>"] = { 
            "toggle_node", 
            nowait = false, -- don't override your leader key
          },
          ["<cr>"] = "open",
          ["l"] = "open",
          ["S"] = "open_split",
          ["s"] = "open_vsplit",
          ["t"] = "open_tabnew",
          ["w"] = "open_with_window_picker",
          ["h"] = "close_node",
          ["z"] = "close_all_nodes",
          ["a"] = { 
            "add",
            config = {
              show_path = "relative" -- "none", "relative", "absolute"
            }
          },
          ["A"] = "add_directory",
          ["d"] = "delete",
          ["r"] = "rename",
          ["c"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["y"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
          ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add":
          ["q"] = "close_window",
          ["?"] = "show_help",
          ["<"] = "prev_source",
          [">"] = "next_source",
        }
      },
      
      filesystem = {
        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false, -- only works on Windows for hidden files/directories
          hide_by_name = {
            ".DS_Store",
            "thumbs.db"
          },
          hide_by_pattern = { -- uses glob style patterns
            --"*.meta",
            --"*/src/*/tsconfig.json",
          },
          always_show = { -- remains visible even if other settings would normally hide it
            ".gitignored",
          },
          never_show = { -- remains hidden even if visible is toggled to true
            ".DS_Store",
            "thumbs.db",
          },
          never_show_by_pattern = { -- uses glob style patterns
            --".null-ls_*",
          },
        },
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        group_empty_dirs = false, -- when true, empty folders will be grouped together
        hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                                                -- ("open_current", "disabled", "open_default", or "disabled")
        use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
                                        -- instead of relying on nvim autocmd events.
        window = {
          mappings = {
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["H"] = "toggle_hidden",
            ["/"] = "fuzzy_finder",
            ["D"] = "fuzzy_finder_directory",
            ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
            ["f"] = "filter_on_submit",
            ["<c-x>"] = "clear_filter",
            ["[g"] = "prev_git_modified",
            ["]g"] = "next_git_modified",
            -- Project management
            ["bp"] = "add_directory_to_projects",
          },
          fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
            ["<down>"] = "move_cursor_down",
            ["<C-n>"] = "move_cursor_down",
            ["<up>"] = "move_cursor_up",
            ["<C-p>"] = "move_cursor_up",
          },
        },
        
        commands = {
          -- Custom command for adding directories to project list
          add_directory_to_projects = function(state)
            local node = state.tree:get_node()
            if node.type == "directory" then
              -- This function will be defined in projects.lua
              require("projects").add_project(node.path)
              vim.notify("Added " .. node.name .. " to projects", vim.log.levels.INFO)
            else
              vim.notify("Please select a directory to add to projects", vim.log.levels.WARN)
            end
          end,  -- Missing comma was here!
        },
      },
      
      buffers = {
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
        },
        -- ... other buffers settings
      },
      
      git_status = {
        window = {
          position = "float",
          mappings = {
            ["A"]  = "git_add_all",
            ["gu"] = "git_unstage_file",
            ["ga"] = "git_add_file",
            ["gr"] = "git_revert_file",
            ["gc"] = "git_commit",
            ["gp"] = "git_push",
            ["gg"] = "git_commit_and_push",
            ["o"]  = { "show_help", nowait = false },
          }
        }
      }
    })
    
    -- Set up keymaps
    vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { silent = true, desc = "Toggle Neotree" })
    vim.keymap.set("n", "<leader>o", ":Neotree focus<CR>", { silent = true, desc = "Focus Neotree" })
    
    -- Focus Neotree when opening vim if in a directory
    local group = vim.api.nvim_create_augroup("neotree_start", { clear = true })
    vim.api.nvim_create_autocmd("VimEnter", {
      desc = "Open Neotree automatically when vim starts up on opening a directory",
      group = group,
      callback = function()
        local stats = vim.loop.fs_stat(vim.fn.argv(0))
        if stats and stats.type == "directory" then
          require("neo-tree.command").execute({ action = "focus" })
        end
      end,
    })
  end,
}
