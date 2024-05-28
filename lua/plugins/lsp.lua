return {
  -- tools
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({
        symbol_in_winbar = {
          enable = true,
        },
        ui = {
          code_action = "♎",
        },
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
        "emmet-language-server",
      })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = function(_, opts)
      opts.show_folds = false
      opts.debug = false
      -- table.insert(opts.show_folds, false)
      -- table.insert(opts.debug, false)
      local max_width = 130
      local width = math.min(math.floor(vim.o.columns * 0.9), max_width)
      local max_height = 50 -- replace with your desired maximum height
      local height = math.min(math.floor(vim.o.lines * 0.9), max_height)

      opts.window = {
        layout = "float", -- 'vertical', 'horizontal', 'float', 'replace'

        width = width, -- fractional width of parent, or absolute width in columns when > 1
        height = height, -- fractional height of parent, or absolute height in rows when > 1
        -- Options below only apply to floating windows
        relative = "editor", -- 'editor', 'win', 'cursor', 'mouse'
        border = "single", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
        row = nil, -- row position of the window, default is centered
        col = nil, -- column position of the window, default is centered
        title = "** Copilot Chat 🤖 **", -- title of chat window
        footer = nil, -- footer of chat window
        zindex = 1, -- determines if window is on top or below other floating windows
      }
    end,
    -- opts = {
    --   function ()
    --
    --   end
    --   show_folds = false,
    --   debug = false, -- Enable debugging
    --   -- See Configuration section for rest
    --   window = {
    --     layout = "float", -- 'vertical', 'horizontal', 'float', 'replace'
    --
    --     width = 0.8, -- fractional width of parent, or absolute width in columns when > 1
    --     height = 0.8, -- fractional height of parent, or absolute height in rows when > 1
    --     -- Options below only apply to floating windows
    --     relative = "editor", -- 'editor', 'win', 'cursor', 'mouse'
    --     border = "single", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
    --     row = nil, -- row position of the window, default is centered
    --     col = nil, -- column position of the window, default is centered
    --     title = "** Copilot Chat 🤖 **", -- title of chat window
    --     footer = nil, -- footer of chat window
    --     zindex = 1, -- determines if window is on top or below other floating windows
    --   },
    -- },
    -- See Commands section for default commands if you want to lazy load on them
  },
  {
    "copilot.lua",
    enabled = false,
  },
  {
    "copilot-cmp",
    enabled = false,
  },

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      ---@type lspconfig.options
      servers = {
        cssls = {},
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
        },
        tsserver = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        html = {},
        lua_ls = {
          -- enabled = false,
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              misc = {
                parameters = {
                  -- "--log-level=trace",
                },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = {
                privateName = { "^_" },
              },
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = true,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
      },
      config = function()
        local nvim_lsp = require("lspconfig")
        local protocol = require("vim.lsp.protocol")

        local on_attach = function(client, bufnr)
          -- format on save
          if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = vim.api.nvim_create_augroup("Format", { clear = true }),
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.formatting_seq_sync()
              end,
            })
          end
        end

        -- TypeScript
        nvim_lsp.tsserver.setup({
          on_attach = on_attach,
          filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
          cmd = { "typescript-language-server", "--stdio" },
        })
      end,
      setup = {},
    },
  },

  {
    "nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-emoji" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-cmdline" },
      { "mlaursen/vim-react-snippets" },
    },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
      require("vim-react-snippets").lazy_load()

      local luasnip = require("luasnip")
      local cmp = require("cmp")
      vim.opt.completeopt = { "menu", "menuone", "noselect" }
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),

        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {

        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, { { name = "cmdline" } }),
      })
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<C-j>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
}
