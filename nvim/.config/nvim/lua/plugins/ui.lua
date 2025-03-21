-- ~/.config/nvim/lua/plugins/ui.lua

return {
  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = function()
      require("nvim-web-devicons").setup({
        -- Override icons if you want
        override = {
          -- Example of override
          zsh = {
            icon = "",
            color = "#428850",
            name = "Zsh"
          }
        },
        -- Same color for all icons that don't have a specific one set
        default = true,
        -- Use this strictly icon and color mapping (no fallback to devicons defaults)
        strict = false,
      })
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local lualine = require("lualine")
      
      -- Configure lualine with a custom setup
      lualine.setup({
        options = {
          icons_enabled = true,
          theme = "tokyonight", -- Matches your colorscheme
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = { "dashboard", "alpha" },
            winbar = { "dashboard", "alpha", "neo-tree" },
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true, -- Use a global statusline across all windows
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { 
            "branch", 
            {
              "diff",
              symbols = {
                added = " ",
                modified = " ",
                removed = " ",
              },
            },
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = " ",
              },
            },
          },
          lualine_c = { 
            {
              "filename",
              path = 1,  -- Show relative path
              symbols = {
                modified = "[+]",
                readonly = "[-]",
                unnamed = "[No Name]",
                newfile = "[New]",
              },
            },
          },
          lualine_x = { 
            -- Custom stats module to show file details
            {
              function()
                local stats = vim.fn.getfsize(vim.fn.expand("%:p"))
                if stats == -1 or stats == 0 then
                  return ""
                else
                  -- Format the file size in a readable format
                  local suffixes = {"B", "KB", "MB", "GB"}
                  local i = 1
                  while stats > 1024 and i < #suffixes do
                    stats = stats / 1024
                    i = i + 1
                  end
                  return string.format("%.1f%s", stats, suffixes[i])
                end
              end,
              icon = "󰈔", -- file-size icon
              color = { fg = "#6e8aad" },
            },
            "encoding", 
            {
              "fileformat",
              symbols = {
                unix = "LF",
                dos = "CRLF",
                mac = "CR",
              },
            },
            "filetype" 
          },
          lualine_y = { "progress" },
          lualine_z = { "location" }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {
          "neo-tree",
          "lazy",
          "toggleterm",
          "man",
          "quickfix",
        }
      })
    end,
  },

  -- Buffer line (tabs)
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        mode = "buffers",
        separator_style = "slant",
        always_show_bufferline = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        color_icons = true,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, _, _)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true,
          },
        },
        hover = {
          enabled = true,
          delay = 200,
          reveal = {"close"},
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      
      -- Set keymaps for buffer navigation
      vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
      vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
      vim.keymap.set("n", "<leader>bp", "<cmd>BufferLinePick<cr>", { desc = "Pick buffer" })
      vim.keymap.set("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", { desc = "Pick buffer to close" })
      vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
      vim.keymap.set("n", "<leader>br", "<cmd>BufferLineCloseRight<cr>", { desc = "Close buffers to the right" })
      vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", { desc = "Close buffers to the left" })
    end,
  },

  -- Better UI elements
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("dressing").setup({
        input = {
          -- Set to false to disable the vim.ui.input implementation
          enabled = true,
          
          -- Default prompt string
          default_prompt = "Input:",
          
          -- Can be 'left', 'right', or 'center'
          prompt_align = "left",
          
          -- When true, <Esc> will close the modal
          insert_only = true,
          
          -- When true, input will start in insert mode
          start_in_insert = true,
          
          -- These are passed to nvim_open_win
          border = "rounded",
          
          -- 'editor' and 'win' will default to being centered
          relative = "cursor",
          
          -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          prefer_width = 40,
          width = nil,
          
          -- Min height for input window
          max_width = nil,
          min_width = 20,
          
          win_options = {
            -- Window transparency (0-100)
            winblend = 10,
            -- Change default highlight groups
            winhighlight = "",
          },
          
          -- Set to `false` to disable
          mappings = {
            n = {
              ["<Esc>"] = "Close",
              ["<CR>"] = "Confirm",
            },
            i = {
              ["<C-c>"] = "Close",
              ["<CR>"] = "Confirm",
              ["<Up>"] = "HistoryPrev",
              ["<Down>"] = "HistoryNext",
            },
          },
          
          override = function(conf)
            -- This is the config that will be passed to nvim_open_win.
            -- Change values here to customize the layout
            return conf
          end,
          
          -- see :help dressing-format
          format = "basic",
        },
        select = {
          -- Set to false to disable the vim.ui.select implementation
          enabled = true,
          
          -- Priority list of preferred vim.select implementations
          backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
          
          -- Trim trailing `:` from prompt
          trim_prompt = true,
          
          -- Options for telescope selector
          -- These are passed into the telescope picker directly. Can be used like:
          -- telescope = require('telescope.themes').get_ivy({...})
          telescope = nil,
          
          -- Options for fzf selector
          fzf = {
            window = {
              width = 0.5,
              height = 0.4,
            },
          },
          
          -- Options for fzf-lua
          fzf_lua = {
            winopts = {
              width = 0.5,
              height = 0.4,
            },
          },
          
          -- Options for nui Menu
          nui = {
            position = "50%",
            size = nil,
            relative = "editor",
            border = {
              style = "rounded",
            },
            buf_options = {
              swapfile = false,
              filetype = "DressingSelect",
            },
            win_options = {
              winblend = 10,
            },
            max_width = 80,
            max_height = 40,
            min_width = 40,
            min_height = 10,
          },
          
          -- Options for built-in selector
          builtin = {
            -- These are passed to nvim_open_win
            border = "rounded",
            
            -- 'editor' and 'win' will default to being centered
            relative = "editor",
            
            win_options = {
              -- Window transparency (0-100)
              winblend = 10,
              winhighlight = "",
            },
            
            -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            -- the min_ and max_ options can be a list of mixed types.
            -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
            width = nil,
            max_width = { 140, 0.8 },
            min_width = { 40, 0.2 },
            height = nil,
            max_height = 0.9,
            min_height = { 10, 0.2 },
            
            -- Set to `false` to disable
            mappings = {
              ["<Esc>"] = "Close",
              ["<C-c>"] = "Close",
              ["<CR>"] = "Confirm",
            },
            
            override = function(conf)
              -- This is the config that will be passed to nvim_open_win.
              -- Change values here to customize the layout
              return conf
            end,
          },
          
          -- Used to override format for custom selections. See :help dressing-format
          format = nil,
        },
      })
    end,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "terminal",
          "lazy",
          "lspinfo",
          "TelescopePrompt",
          "TelescopeResults",
          "mason",
          "nvdash",
          "nvcheatsheet",
          "",
        },
        buftypes = { "terminal" },
      },
    },
  },

  -- Window picker
  {
      's1n7ax/nvim-window-picker',
      name = 'window-picker',
      event = 'VeryLazy',
      version = '2.*',
      config = function()
          require'window-picker'.setup(
	  {
	    hint = 'statusline-winbar',

	    -- This section contains picker specific configurations
	    picker_config = {
		-- whether should select window by clicking left mouse button on it
		handle_mouse_click = true,
		statusline_winbar_picker = {
		    -- `return char .. ': %f'` to display buffer file path in status bar.. See :h 'stl' for details.
		    selection_display = function(char, windowid)
			return '%=' .. char .. ': $f'
		    end,

		    use_winbar = 'smart',
		},
	    },

	  }
	  )
      end,
  },

  -- UI for messages, cmdline and the popup menu
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    config = function(_, opts)
      require("noice").setup(opts)
      
      -- Keymaps for Noice history navigation
      vim.keymap.set("n", "<leader>nh", "<cmd>Noice history<CR>", { desc = "View message history" })
      vim.keymap.set("n", "<leader>nn", "<cmd>Noice last<CR>", { desc = "View last message" })
      vim.keymap.set("n", "<leader>ne", "<cmd>Noice errors<CR>", { desc = "View error messages" })
      
      -- Clear notifications
      vim.keymap.set("n", "<leader>nc", "<cmd>Noice dismiss<CR>", { desc = "Clear notifications" })
    end,
  },

}
