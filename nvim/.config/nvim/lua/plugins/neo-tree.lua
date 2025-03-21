-- ~/.config/nvim/lua/plugins/neo-tree.lua

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- for file icons
    "MunifTanjim/nui.nvim",
    "s1n7ax/nvim-window-picker",
  },
  config = function()
    -- Unless you are still migrating, remove the deprecated commands
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

    -- Get the projects module for better integration
    local projects_module = require("projects")
    
    require("neo-tree").setup({
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        -- Add document symbols source when LSP is available
        "document_symbols",
      },
      
      source_selector = {
        winbar = true,
        content_layout = "center",
        sources = {
          { source = "filesystem", display_name = " Files" },
          { source = "buffers", display_name = " Buffers" },
          { source = "git_status", display_name = " Git" },
          { source = "document_symbols", display_name = " Symbols" },
        },
      },
      
      -- General configuration
      use_popups_for_input = false,
      use_default_mappings = false,  
      
      default_component_configs = {
        container = {
          enable_character_fade = true
        },
        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          highlight = "NeoTreeIndentMarker",
          with_expanders = true,
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
        -- Add file size and last modified date
        file_size = {
          enabled = true,
          required_width = 64,
        },
        type = {
          enabled = true,
          required_width = 122,
        },
        last_modified = {
          enabled = true,
          required_width = 88,
        },
        created = {
          enabled = true,
          required_width = 110,
        },
        symlink_target = {
          enabled = false,
        },
      },
      
      -- Window configuration
      window = {
        position = "left",
        width = 30,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          -- Mouse mappings
          ["<2-LeftMouse>"] = "open",
          ["<RightMouse>"] = { "show_file_details", nowait = false },
          
          -- Navigation
          ["<space>"] = { "toggle_node", nowait = false },
          ["<cr>"] = "open",
          ["l"] = "open",
          ["S"] = "open_split",
          ["s"] = "open_vsplit",
          ["t"] = "open_tabnew",
          ["w"] = "open_with_window_picker",
          ["h"] = "close_node",
          ["z"] = "close_all_nodes",
          ["Z"] = "expand_all_nodes",
          
          -- Parent/child navigation (ranger-style)
          ["H"] = "navigate_up", -- Go to parent directory
          ["L"] = "set_root",   -- cd into directory (set root)
          
          -- File/directory operations
          ["a"] = { 
            "add",
            config = {
              show_path = "relative"
            }
          },
          ["A"] = "add_directory",
          ["d"] = "delete",
          ["r"] = "rename",
          ["c"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["y"] = "copy",
          ["m"] = "move",
          ["R"] = "refresh",
          
          -- File details and toggles
          ["i"] = "show_file_details",
          ["."] = "toggle_hidden",
          ["f"] = "filter_on_submit",
          ["<C-x>"] = "clear_filter",
          ["<bs>"] = "navigate_up",
          
          -- Searching and filtering
          ["/"] = "fuzzy_finder",
          ["?"] = "show_help",
          ["F"] = "fuzzy_finder_directory",
          
          
          -- Git navigation
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
          
          
          -- Quick navigation
          ["gh"] = "toggle_hidden",  -- Toggle hidden files
          ["gp"] = "focus_preview",  -- Focus the preview window
          ["gf"] = "telescope_find",  -- Search with Telescope
          ["P"] = "toggle_preview",  -- Toggle preview
          
          -- Project management
          ["bp"] = "add_directory_to_projects",
          
          -- Close window
          ["q"] = "close_window",
          ["<esc>"] = "close_window",
          
          -- Quick view modes
          ["v"] = "quick_view_mode",
        }
      },
      
      -- Filesystem specific configuration
      filesystem = {
        filtered_items = {
          visible = true, -- Show filtered items with reduced opacity
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
          hide_by_name = {
            ".DS_Store",
            "thumbs.db"
          },
          never_show = {
            ".DS_Store",
            "thumbs.db",
          },
        },
        find_by_full_path_words = true,  -- Search by any part of file path
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        group_empty_dirs = false,
        hijack_netrw_behavior = "open_default",
        use_libuv_file_watcher = true,
        
        -- Enable search with fd command if available
        search_limit = 50,  
        
        commands = {
          -- Add custom commands
          add_directory_to_projects = function(state)
            local node = state.tree:get_node()
            if node.type == "directory" then
              -- This function defined in projects.lua
              projects_module.add_project(node.path)
              vim.notify("Added " .. node.name .. " to projects", vim.log.levels.INFO)
            else
              vim.notify("Please select a directory to add to projects", vim.log.levels.WARN)
            end
          end,
          
          -- Custom command to search with Telescope
          telescope_find = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            require("telescope.builtin").find_files({
              prompt_title = "Find Files in " .. node.name,
              cwd = node.type == "directory" and path or vim.fn.fnamemodify(path, ":h"),
            })
          end,
          
          -- Quick view mode (toggle between different view modes)
          quick_view_mode = function(state)
            local view_modes = {
              "name",
              "name_and_file_size",
              "name_and_last_modified",
              "name_and_details",
            }
            
            -- Get or set current view mode
            state.view_mode = state.view_mode or 1
            state.view_mode = state.view_mode % #view_modes + 1
            
            -- Apply the view mode
            local mode = view_modes[state.view_mode]
            vim.notify("View Mode: " .. mode, vim.log.levels.INFO)
            
            -- Configure the components based on mode
            if mode == "name" then
              -- Simple view with just names
              state.components = {"indent", "icon", "name"}
            elseif mode == "name_and_file_size" then
              -- Show name and file size
              state.components = {"indent", "icon", "name", "file_size"}
            elseif mode == "name_and_last_modified" then
              -- Show name and last modified date
              state.components = {"indent", "icon", "name", "last_modified"}
            else
              -- Show all details
              state.components = {"indent", "icon", "name", "file_size", "type", "last_modified"}
            end
            
            -- Refresh to apply changes
            require("neo-tree.sources.filesystem").refresh(state)
          end,
          
          -- Display basic file info
          show_file_details = function(state)
            local node = state.tree:get_node()
            if node.type == "file" then
              -- Execute the stat command to get file details
              local cmd = string.format("stat -c 'Size: %%s bytes\\nPermissions: %%A\\nModified: %%y\\nAccessed: %%x\\nCreated: %%w' '%s'", node.path)
              local handle = io.popen(cmd)
              if handle then
                local result = handle:read("*a")
                handle:close()
                vim.notify("File Info - " .. node.name .. "\n" .. result, vim.log.levels.INFO, {
                  title = "File Details",
                  timeout = 5000,
                })
              end
            else
              vim.notify("Directory: " .. node.name, vim.log.levels.INFO)
            end
          end,
        },
        
        window = {
          mappings = {
            -- Filesystem specific mappings
            ["/"] = "fuzzy_finder",
            ["D"] = "fuzzy_finder_directory",
            ["."] = "set_root",
            ["H"] = "navigate_up",
            ["<bs>"] = "navigate_up",
            ["-"] = "navigate_up",
            ["f"] = "filter_on_submit",
            ["<c-x>"] = "clear_filter",
          }
        }
      },
      
      -- Buffers source configuration
      buffers = {
        follow_current_file = {
          enabled = true,
        },
        group_empty_dirs = true,
        show_unloaded = true,
        window = {
          mappings = {
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["d"] = "buffer_delete",
          }
        },
      },
      
      -- Git status source configuration
      git_status = {
        window = {
          mappings = {
            ["A"]  = "git_add_all",
            ["gu"] = "git_unstage_file",
            ["ga"] = "git_add_file",
            ["gr"] = "git_revert_file",
            ["gc"] = "git_commit",
            ["gp"] = "git_push",
            ["gg"] = "git_commit_and_push",
          }
        }
      },
      
      -- Document symbols source (requires LSP)
      document_symbols = {
        follow_cursor = true,
        client_filters = "first",
        renderers = {
          root = {
            {"indent"},
            {"icon", default="C"},
            {"name", zindex = 10},
          },
          symbol = {
            {"indent", with_expanders = true},
            {"kind_icon", default="?"},
            {"container", content = {
              {"name", zindex = 10},
              {"kind_name", zindex = 20, align = "right"},
            }}
          },
        },
      },
    })
    
    -- Set up keymaps with more descriptive labels
    vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { silent = true, desc = "Toggle file explorer" })
    vim.keymap.set("n", "<leader>o", ":Neotree focus<CR>", { silent = true, desc = "Focus file explorer" })
    vim.keymap.set("n", "<leader>O", ":Neotree reveal<CR>", { silent = true, desc = "Reveal file in explorer" })
    
    -- Add commands for different Neo-tree sources
    vim.keymap.set("n", "<leader>be", ":Neotree buffers toggle<CR>", { silent = true, desc = "Toggle buffer explorer" })
    vim.keymap.set("n", "<leader>ge", ":Neotree git_status toggle<CR>", { silent = true, desc = "Toggle git explorer" })
    vim.keymap.set("n", "<leader>se", ":Neotree document_symbols toggle<CR>", { silent = true, desc = "Toggle symbols explorer" })
    
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
    
    -- Enhance directory navigation with custom commands
    vim.api.nvim_create_user_command("CD", function(opts)
      -- Change directory and update Neo-tree
      vim.cmd("cd " .. opts.args)
      require("neo-tree.command").execute({ action = "refresh" })
    end, { nargs = 1, complete = "dir" })
    
    -- Command to show the current file in Neo-tree
    vim.api.nvim_create_user_command("NeoTreeFind", function()
      require("neo-tree.command").execute({ action = "reveal", reveal_force_cwd = true })
    end, {})
  end,
}
