return {
  -- Hihglight colors
  -- {
  --   "easymotion/vim-easymotion",
  --
  --
  --

  {

    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below useState
      -- ust
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        useState = { icon = "🔑", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults
    },
  },
  {

    "folke/flash.nvim",
    enabled = false,
  },
  {
    "ggandor/leap.nvim",
    enabled = false,
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>t"] = { name = "🖥️terminal🖥️" },
        ["<leader>m"] = { name = "markdown prefix" },
        ["<leader>0"] = { name = "Copilot 🤖" },
      },
    },
  }, -- },
  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
    opts = {},
  },
  {

    "https://github.com/preservim/tagbar",
  },
  {
    "telescope.nvim",
    priority = 1000,
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-file-browser.nvim",
    },
    keys = {

      {
        "\\\\g",
        function()
          local builtin = require("telescope.builtin")
          builtin.live_grep({
            vimgrep_arguments = {
              "rg",
              "--color=never",
              "--no-heading",
              "--with-filename",
              "--line-number",
              "--column",
              "--smart-case",
              "--glob=!.git/",
              "--glob=!node_modules/",
            },
          })
        end,
        desc = "grep current workign directory",
      },
      {

        "\\g",
        function()
          local builtin = require("telescope.builtin")
          local current_file = vim.fn.expand("%:p")
          builtin.live_grep({
            search_dirs = { current_file }, -- Sets the search directory to the current file's directory
          })
          -- Function to perform a grep search on the current file using Telescope
        end,
        -- Function to live grep in the current file using Telescope

        desc = "grep current file",
      },

      {
        "\\f",
        function()
          local builtin = require("telescope.builtin")
          builtin.find_files({
            find_command = { "rg", "--files", "--hidden", "--no-ignore", "--glob=!.git/", "--glob=!node_modules/" },
            no_ignore = true,
            hidden = true,
          })
        end,
        desc = "Lists files in your current working directory, respects .gitignore",
      },
      -- {
      --   ";r",
      --   function()
      --     local builtin = require("telescope.builtin")
      --     builtin.live_grep()
      --   end,
      --   desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
      -- },
      {
        "\\b",
        function()
          local builtin = require("telescope.builtin")
          builtin.buffers()
        end,
        desc = "Lists open buffers",
      },

      -- {
      --   ";;",
      --   function()
      --     local builtin = require("telescope.builtin")
      --
      --     builtin.resume()
      --   end,
      --   desc = "Resume the previous telescope picker",
      -- },
      -- {
      --   ";e",
      --   function()
      --     local builtin = require("telescope.builtin")
      --     builtin.diagnostics()
      --   end,
      --   desc = "Lists Diagnostics for all open buffers or a specific buffer",
      -- },

      {
        "\\t",
        function()
          local symbol_descriptions = {
            { symbol = "Symbol1", description = "Description for Symbol1", filepath = vim.fn.expand("%:p") },
            { symbol = "Symbol2", description = "Description for Symbol2", filepath = vim.fn.expand("%:p") },
            -- Add more symbols, descriptions, and file paths as needed
          }
          local builtin = require("telescope.builtin")
          builtin.treesitter()
        end,
        desc = "Lists Function names, variables, from Treesitter",
      },
      {
        "\\ls",
        function()
          local telescope = require("telescope.builtin")
          local actions = require("telescope.actions")
          local action_state = require("telescope.actions.state")

          local function telescope_buffer_dir()
            return vim.fn.expand("%:p:h")
          end
          local open_in_new_tab = function(bufnr)
            local selection = action_state.get_selected_entry()
            actions.close(bufnr)
            vim.cmd("tabnew " .. selection.path)
          end
          telescope.find_files({
            search_dirs = { telescope_buffer_dir() }, -- Set the search directory to the current buffer's directory
            cwd = telescope_buffer_dir(),
            hidden = false,
            no_ignore = false, -- Respect .gitignore
            -- layout_strategy = "horizontal",
            -- layout_config = {
            --   height = 0.99, -- Use 100% of the height of Neovim
            --   width = 0.99, -- Use 100% of the width of Neovim
            --   -- preview_cutoff = 0,
            --   preview_width = 0.8,
            --   prompt_position = "top",
            -- },
            -- attach_mappings = function(_, map)
            --   -- Map the <CR> (Enter) key to open the file in a new tab
            --   map("i", "<CR>", open_in_new_tab)
            --   map("n", "<CR>", open_in_new_tab)
            --   return true -- Return true to keep default mappings as well, remove to only use custom mapping
            -- end,
          })
        end,
        desc = "Open File Browser with the path of the current buffer",
      },

      {
        "\\nt",
        function()
          local telescope = require("telescope.builtin")
          local actions = require("telescope.actions")
          local action_state = require("telescope.actions.state")

          local function telescope_buffer_dir()
            return vim.fn.expand("%:p:h")
          end
          local open_in_new_tab = function(bufnr)
            local selection = action_state.get_selected_entry()
            actions.close(bufnr)
            vim.cmd("tabnew " .. selection.path)
          end
          telescope.find_files({
            search_dirs = { telescope_buffer_dir() }, -- Set the search directory to the current buffer's directory
            cwd = telescope_buffer_dir(),
            hidden = false,
            no_ignore = false, -- Respect .gitignore
            -- layout_strategy = "horizontal",
            -- layout_config = {
            --   height = 0.99, -- Use 100% of the height of Neovim
            --   width = 0.99, -- Use 100% of the width of Neovim
            --   -- preview_cutoff = 0,
            --   preview_width = 0.8,
            --   prompt_position = "top",
            -- },
            attach_mappings = function(_, map)
              -- Map the <CR> (Enter) key to open the file in a new tab
              map("i", "<CR>", open_in_new_tab)
              map("n", "<CR>", open_in_new_tab)
              return true -- Return true to keep default mappings as well, remove to only use custom mapping
            end,
          })
        end,
        desc = "File Browser current buffer directory new Tab",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions

      opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
        wrap_results = true,
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          n = {},
        },
      })
      opts.pickers = {
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal",
          layout_config = {
            preview_cutoff = 9999,
          },
        },
      }
      opts.extensions = {
        file_browser = {
          theme = "dropdown",
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          mappings = {
            -- your custom insert mode mappings
            ["n"] = {
              -- your custom normal mode mappings
              ["N"] = fb_actions.create,
              ["h"] = fb_actions.goto_parent_dir,
              ["<C-u>"] = function(prompt_bufnr)
                for i = 1, 10 do
                  actions.move_selection_previous(prompt_bufnr)
                end
              end,
              ["<C-d>"] = function(prompt_bufnr)
                for i = 1, 10 do
                  actions.move_selection_next(prompt_bufnr)
                end
              end,
            },
          },
        },
      }
      telescope.setup(opts)
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("file_browser")
    end,
  },
}
