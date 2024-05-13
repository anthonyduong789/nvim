return {
  -- Hihglight colors
  -- {
  --   "easymotion/vim-easymotion",
  --
  --
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

        "<Leader>flg",
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

      -- {
      --   ";f",
      --   function()
      --     local builtin = require("telescope.builtin")
      --     builtin.find_files({
      --       no_ignore = false,
      --       hidden = true,
      --     })
      --   end,
      --   desc = "Lists files in your current working directory, respects .gitignore",
      -- },
      -- {
      --   ";r",
      --   function()
      --     local builtin = require("telescope.builtin")
      --     builtin.live_grep()
      --   end,
      --   desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
      -- },
      {
        "\\\\",
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
        "<leader>ft",
        function()
          local builtin = require("telescope.builtin")
          builtin.treesitter()
        end,
        desc = "Lists Function names, variables, from Treesitter",
      },
      {
        "<leader>fls",
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
        "<Leader>nt",
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
