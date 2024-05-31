return {
  --
  --   "nvimdev/dashboard-nvim",
  --   enabled = true,
  -- },
  --
  --
  --
  -- animations
  {
    "echasnovski/mini.animate",
    enabled = true,
    event = "VeryLazy",
    opts = function(_, opts)
      opts.scroll = {
        enable = false,
      }
    end,
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",

    opts = function()
      local max_width = 140
      local width = math.min(max_width, (vim.o.columns * 0.7))

      return {
        window = {
          backdrop = 0.1,
          zindex = 4,
          width = width,
        },

        plugins = {
          gitsigns = true,
          tmux = true,
          kitty = { enabled = false, font = "+2" },
        },
      }
    end,

    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },
  {
    -- NOTE: provides a healines of how to markdown files
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      -- Define custom highlight groups using Vimscript
      vim.cmd([[highlight Headline1 guibg=#295715 guifg=white]])
      vim.cmd([[highlight Headline2 guibg=#8d8200 guifg=white]])
      vim.cmd([[highlight Headline3 guibg=#a56106 guifg=white]])
      vim.cmd([[highlight Headline4 guibg=#7e0000 guifg=white]])
      vim.cmd([[highlight Headline5 guibg=#1e0b7b guifg=white]])
      vim.cmd([[highlight Headline6 guibg=#560b7b guifg=white]])
      -- Defines the codeblock background color to something darker
      vim.cmd([[highlight CodeBlock guibg=#09090d]])
      -- When you add a line of dashes with --- this specifies the color, I'm not
      -- adding a "guibg" but you can do so if you want to add a background color
      vim.cmd([[highlight Dash guifg=white]])

      -- Setup headlines.nvim with the newly defined highlight groups
      require("headlines").setup({
        markdown = {
          -- If set to false, headlines will be a single line and there will be no
          -- "fat_headline_upper_string" and no "fat_headline_lower_string"
          fat_headlines = true,
          --
          -- Lines added above and below the header line makes it look thicker
          -- "lower half block" unicode symbol hex:2584
          -- "upper half block" unicode symbol hex:2580
          fat_headline_upper_string = "▄",
          fat_headline_lower_string = "▀",
          --
          -- You could add a full block if you really like it thick ;)
          -- fat_headline_upper_string = "█",
          -- fat_headline_lower_string = "█",
          --
          -- Other set of lower and upper symbols to try
          -- fat_headline_upper_string = "▃",
          -- fat_headline_lower_string = "-",
          --
          headline_highlights = {
            "Headline1",
            "Headline2",
            "Headline3",
            "Headline4",
            "Headline5",
            "Headline6",
          },
        },
      })
    end,
  },
  {
    -- NOTE: launches markdown to the browser
    "davidgranstrom/nvim-markdown-preview",
    enabled = true,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = true,
  },
  {
    "nvim-lualine/lualine.nvim",
    enabled = true,
    opts = {
      options = {
        theme = "solarized_dark",
      },
      -- sections = {
      --   lualine_x = {
      --     {
      --       require("noice").api.statusline.mode.get,
      --       cond = require("noice").api.statusline.mode.has,
      --       color = { fg = "#ff9e64" },
      --     },
      --     {
      --       require("noice").api.status.command.get,
      --       cond = require("noice").api.status.command.has,
      --       color = { fg = "#ff9e64" },
      --     },
      --   },
      --   -- lualine_a = {
      --   --   {
      --   --     "tabs",
      --   --   },
      --   -- },
      -- },
    },
  },
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    enabled = true,
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      -- local focused = true
      -- vim.api.nvim_create_autocmd("FocusGained", {
      --   callback = function()
      --     focused = true
      --   end,
      -- })
      -- vim.api.nvim_create_autocmd("FocusLost", {
      --   callback = function()
      --     focused = false
      --   end,
      -- })
      -- table.insert(opts.routes, 1, {
      --   filter = {
      --     cond = function()
      --       return not focused
      --     end,
      --   },
      --   view = "notify_send",
      --   opts = { stop = false },
      -- })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      opts.presets.lsp_doc_border = true
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
      background_colour = "#000000",
      render = "wrapped-compact",
    },
  },

  -- buffer line
  {
    -- NOTE: SHOWS THE TOP OF THE Endior
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      -- { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      -- { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        -- mode = "buffers", -- set to "tabs" to only show tabpages instead
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
        -- buffer_close_icon = "󰅖",
        separator_style = "thin", -- "slant"| "slope" | "thick" | "thin" | { 'any', 'any' },
        buffer_close_icon = "🎲",
        inlay_hints = { enabled = true },
      },
    },
  },

  -- filename
  {
    -- NOTE: top right ft_icon
    "b0o/incline.nvim",
    dependencies = {},
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local helpers = require("incline.helpers")
      require("incline").setup({
        window = {
          padding = 0,
          margin = { horizontal = 0, vertical = 2 },
          zindex = 1,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          local buffer = {
            ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
            " ",
            { filename, gui = modified and "bold,italic" or "bold" },
            " ",
            guibg = "#363944",
          }
          return buffer
        end,
      })
    end,
  },
  -- LazyGit integration with Telescope
  {
    "kdheepak/lazygit.nvim",
    keys = {
      {
        ";c",
        ":LazyGit<Return>",
        silent = true,
        noremap = true,
      },
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    keys = {
      {

        "<leader>d",
        "<cmd>NvimTreeClose<cr><cmd>tabnew<cr><bar><bar><cmd>DBUI<cr>",
      },
    },
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      --       local logo = [[
      -- ██╗  ██╗███████╗██╗     ██╗      ██████╗     ██╗    ██╗ ██████╗ ██████╗ ██╗     ██████╗
      -- ██║  ██║██╔════╝██║     ██║     ██╔═══██╗    ██║    ██║██╔═══██╗██╔══██╗██║     ██╔══██╗
      -- ███████║█████╗  ██║     ██║     ██║   ██║    ██║ █╗ ██║██║   ██║██████╔╝██║     ██║  ██║
      -- ██╔══██║██╔══╝  ██║     ██║     ██║   ██║    ██║███╗██║██║   ██║██╔══██╗██║     ██║  ██║
      -- ██║  ██║███████╗███████╗███████╗╚██████╔╝    ╚███╔███╔╝╚██████╔╝██║  ██║███████╗██████╔╝
      -- ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝ ╚═════╝      ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝
      --
      -- ]]
      --
      --       ]]
      local logo = [[
      ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
      ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
      ░░░░░░░░░░░┌───┬───┐░┌┬───┐░░░░░░░░░░┌───┐░┌┐░┌┐░░░░░░░░░░░░░░░░
      ░░░░░░░░░░░│┌─┐│┌─┐│░││┌──┘░░░░░░░░░░│┌──┘░││┌┘└┐░░░░░░░░░░░░░░░
      ░░░░░░░░░░░││░└┤│░│├─┘│└──┐░░░░░░░░░░│└──┬─┘├┼┐┌┼──┬─┐░░░░░░░░░░
      ░░░░░░░░░░░││░┌┤│░││┌┐│┌──┘░░░░░░░░░░│┌──┤┌┐├┤│││┌┐│┌┘░░░░░░░░░░
      ░░░░░░░░░░░│└─┘│└─┘│└┘│└──┐┌┬┬┬┬┬┬┬┬┬┤└──┤└┘│││└┤└┘││░░░░░░░░░░░
      ░░░░░░░░░░░└───┴───┴──┴───┘└┴┴┴┴┴┴┴┴┴┴───┴──┴┘└─┴──┴┘░░░░░░░░░░░
      ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
      ░░░░░░░░░░░░░░░░▄█▀█▄░░░░░░░░░░░░░░░░░▄▄▄▄▄▀██▀▀▀█░░░░░░░░░░░░░░
      ░░░░░░░░░░░░░░▐░░░░░░▀▄▄░░░░░░░░░░░░░█░░░░░░░░░░░▐░░░░░░░░░░░░░░
      ░░░░░░░░░░░░░░█░██░░▐█░▀█░░░░░░░░░░░░█░▄░░░░░░▄▄░▐░░░░░░░░░░░░░░
      ░░░░░░░░░░░░░░░█░░░░░░░░░▌░░░░░░░░░░░▐░▀░░░░░░▀▀░░▌░░░░░░░░░░░░░
      ░░░░░░░░░░░░░░░░██▀▀▀█░░░▌░█████░░░░░▐░░░░█▀▀░░░░░▌░░░░░░░░░░░░░
      ░░░░░░░░░░░░░░░░░░█▄░░░█▀░░█░░░░░░░░░▐░░░░░░░░░░░▄▌░░░░░░░░░░░░░
      ░░░░░░░░░░░░░░░░░░░░█▀▀░░▄██░░░░░░░░░▐▄▄▄▄▄█▀▀▀▀▀░░░░░░░░░░░░░░░
      ░░░░░░░░░░░░░░░░░░░▀█▄█▀▀░░░░░░░░░░░░░░▄▄▄█░█▀▀░░░░░░░░░░░░░░░░░
      ░░░░░░░░░░░░░░░░░░░░█░░░░░░░░░░░░░░░░░░░░░█░░░░░░░░░░░░░░░░░░░░░
      ░░░░░░░░░░░░░░░░░░█░░█░░░░░░░░░░░░░░░░░░▄▀░█░░░░░░░░░░░░░░░░░░░░
      ░░░░░░░░░░░░░░░░░▀░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
            ]]

      logo = string.rep("\n", (vim.o.lines * 0.2)) .. logo .. ""
      opts.config.header = vim.split(logo, "\n")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "LazyFile",
    opts = { mode = "cursor", max_lines = 1, zindex = 50 },
    keys = {
      {
        "<leader>ut",
        function()
          local tsc = require("treesitter-context")
          tsc.toggle()
          if LazyVim.inject.get_upvalue(tsc.toggle, "enabled") then
            LazyVim.info("Enabled Treesitter Context", { title = "Option" })
          else
            LazyVim.warn("Disabled Treesitter Context", { title = "Option" })
          end
        end,
        desc = "Toggle Treesitter Context",
      },
    },
  },
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   config = function()
  --     require("nvim-tree").setup({
  --       on_attach = function(bufnr)
  --         local api = require("nvim-tree.api")
  --
  --         local function opts(desc)
  --           return {
  --             desc = "nvim-tree: " .. desc,
  --             buffer = bufnr,
  --             noremap = true,
  --             silent = true,
  --             nowait = true,
  --           }
  --         end
  --
  --         -- default mappings
  --         api.config.mappings.default_on_attach(bufnr)
  --
  --         -- custom mappings
  --         vim.keymap.set("n", "t", api.node.open.tab, opts("Tab"))
  --       end,
  --       actions = {
  --         open_file = {
  --           quit_on_open = true,
  --         },
  --       },
  --       sort = {
  --         sorter = "case_sensitive",
  --       },
  --       view = {
  --         width = 30,
  --         relativenumber = true,
  --       },
  --       renderer = {
  --         group_empty = true,
  --       },
  --       filters = {
  --         dotfiles = true,
  --         custom = {
  --           "node_modules/.*",
  --         },
  --       },
  --       log = {
  --         enable = true,
  --         truncate = true,
  --         types = {
  --           diagnostics = true,
  --           git = true,
  --           profile = true,
  --           watcher = true,
  --         },
  --       },
  --     })
  --
  --     if vim.fn.argc(-1) == 0 then
  --       vim.cmd("NvimTreeFocus")
  --     end
  --   end,
  -- },
}
