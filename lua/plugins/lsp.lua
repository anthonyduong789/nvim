return {
  -- tools
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({
        symbol_in_winbar = {
          enable = false,
        },
        ui = {
          code_action = "",
        },
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
  },
  -- {
  --   "williamboman/mason.nvim",
  --   opts = function(_, opts)
  --     vim.list_extend(opts.ensure_installed, {
  --       "luacheck",
  --       "shellcheck",
  --       "shfmt",
  --       "tailwindcss-language-server",
  --       "typescript-language-server",
  --       "css-lsp",
  --       "emmet-language-server",
  --       "marksman",
  --       "markdownlint",
  --     })
  --   end,
  -- },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },

    opts = function()
      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)
      local max_width = 130
      local width = math.min(math.floor(vim.o.columns * 0.9), max_width)
      local max_height = 50 -- replace with your desired maximum height
      local height = math.min(math.floor(vim.o.lines * 0.9), max_height)
      return {
        model = "gpt-4",
        debug = false,
        auto_insert_mode = true,
        show_help = true,
        question_header = "  " .. user .. " ",
        answer_header = "  Copilot ",
        window = {
          layout = "float", -- 'vertical', 'horizontal', 'float', 'replace'

          width = width, -- fractional width of parent, or absolute width in columns when > 1
          height = height, -- fractional height of parent, or absolute height in rows when > 1
          -- Options below only apply to floating windows
          relative = "editor", -- 'editor', 'win', 'cursor', 'mouse'
          border = "rounded", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
          row = 0, -- row position of the window, default is centered
          col = nil, -- column position of the window, default is centered
          title = "** Copilot Chat 🤖 **", -- title of chat window
          -- footer = "👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽", -- footer of chat window
          zindex = 52, -- determines if window is on top or below other floating windows
        },
        selection = function(source)
          local select = require("CopilotChat.select")
          return select.visual(source) or select.buffer(source)
        end,
      }
    end,
    keys = {
      {
        "<leader>0q",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input)
          end
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },

      {
        "<leader>0c",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "v" },
      },

      {
        "<leader>0t",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      -- Show help actions with telescope
      {
        "<leader>0d",
        function()
          local actions = require("CopilotChat.actions")
          local help = actions.help_actions()
          if not help then
            LazyVim.warn("No diagnostics found on the current line")
            return
          end
          require("CopilotChat.integrations.telescope").pick(help)
        end,
        desc = "Diagnostic Help (CopilotChat)",
        mode = { "n", "v" },
      },
      -- Show prompts actions with telescope
      {
        "<leader>0p",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "Prompt Actions (CopilotChat)",
        mode = { "n", "v" },
      },
    },
    init = function()
      LazyVim.on_load("which-key.nvim", function()
        vim.schedule(function()
          require("which-key").register({ a = { name = "+CopilotChat (AI)" } }, { prefix = "<leader>" })
        end)
      end)
    end,
    config = function(_, opts)
      local chat = require("CopilotChat")

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = true
        end,
      })

      chat.setup(opts)
    end,
  },
  {
    "copilot.lua",
    enabled = true,
  },
  {
    "copilot-cmp",
    enabled = true,
  },

  -- lsp servers
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     inlay_hints = { enabled = true },
  --     ---@type lspconfig.options
  --     servers = {
  --       marksman = {},
  --       cssls = {},
  --       tailwindcss = {
  --         root_dir = function(...)
  --           return require("lspconfig.util").root_pattern(".git")(...)
  --         end,
  --       },
  --       -- tsserver = {
  --       --   -- on_attach = on_attach,
  --       --   -- filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  --       --   -- cmd = { "typescript-language-server", "--stdio" },
  --       --   settings = {
  --       --     typescript = {
  --       --       inlayHints = {
  --       --         includeInlayParameterNameHints = "all",
  --       --         includeInlayParameterNameHintsWhenArgumentMatchesName = true,
  --       --         includeInlayFunctionParameterTypeHints = true,
  --       --         includeInlayVariableTypeHints = true,
  --       --         includeInlayPropertyDeclarationTypeHints = true,
  --       --         includeInlayFunctionLikeReturnTypeHints = true,
  --       --         includeInlayEnumMemberValueHints = true,
  --       --       },
  --       --     },
  --       --     javascript = {
  --       --       inlayHints = {
  --       --         includeInlayParameterNameHints = "all",
  --       --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  --       --         includeInlayFunctionParameterTypeHints = true,
  --       --         includeInlayVariableTypeHints = true,
  --       --         includeInlayPropertyDeclarationTypeHints = true,
  --       --         includeInlayFunctionLikeReturnTypeHints = true,
  --       --         includeInlayEnumMemberValueHints = true,
  --       --       },
  --       --     },
  --       --   },
  --       -- },
  --       html = {},
  --       lua_ls = {
  --         -- enabled = false,
  --         single_file_support = true,
  --         settings = {
  --           Lua = {
  --             workspace = {
  --               checkThirdParty = false,
  --             },
  --             completion = {
  --               workspaceWord = true,
  --               callSnippet = "Both",
  --             },
  --             misc = {
  --               parameters = {
  --                 -- "--log-level=trace",
  --               },
  --             },
  --             hint = {
  --               enable = true,
  --               setType = false,
  --               paramType = true,
  --               paramName = "Disable",
  --               semicolon = "Disable",
  --               arrayIndex = "Disable",
  --             },
  --             doc = {
  --               privateName = { "^_" },
  --             },
  --             type = {
  --               castNumberToInteger = true,
  --             },
  --             diagnostics = {
  --               disable = { "incomplete-signature-doc", "trailing-space" },
  --               -- enable = false,
  --               groupSeverity = {
  --                 strong = "Warning",
  --                 strict = "Warning",
  --               },
  --               groupFileStatus = {
  --                 ["ambiguity"] = "Opened",
  --                 ["await"] = "Opened",
  --                 ["codestyle"] = "None",
  --                 ["duplicate"] = "Opened",
  --                 ["global"] = "Opened",
  --                 ["luadoc"] = "Opened",
  --                 ["redefined"] = "Opened",
  --                 ["strict"] = "Opened",
  --                 ["strong"] = "Opened",
  --                 ["type-check"] = "Opened",
  --                 ["unbalanced"] = "Opened",
  --                 ["unused"] = "Opened",
  --               },
  --               unusedLocalExclude = { "_*" },
  --             },
  --             format = {
  --               enable = true,
  --               defaultConfig = {
  --                 indent_style = "space",
  --                 indent_size = "2",
  --                 continuation_indent_size = "2",
  --               },
  --             },
  --           },
  --         },
  --       },
  --     },
  --     config = function()
  --       local nvim_lsp = require("lspconfig")
  --       local protocol = require("vim.lsp.protocol")
  --
  --       local on_attach = function(client, bufnr)
  --         local function buf_set_keymap(...)
  --           vim.api.nvim_buf_set_keymap(bufnr, ...)
  --         end
  --         local opts = { noremap = true, silent = true }
  --
  --         buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  --         buf_set_keymap("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
  --         buf_set_keymap("n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  --         buf_set_keymap("n", "gs", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  --         buf_set_keymap("n", "<leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
  --         buf_set_keymap("n", "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  --         buf_set_keymap("n", "<leader>f", "<Cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  --
  --         client.resolved_capabilities.document_formatting = true
  --         client.resolved_capabilities.document_range_formatting = true
  --       end
  --       -- local on_attach = function(client, bufnr)
  --       --   -- format on save
  --       --   if client.server_capabilities.documentFormattingProvider then
  --       --     vim.api.nvim_create_autocmd("BufWritePre", {
  --       --       group = vim.api.nvim_create_augroup("Format", { clear = true }),
  --       --       buffer = bufnr,
  --       --       callback = function()
  --       --         vim.lsp.buf.formatting_seq_sync()
  --       --       end,
  --       --     })
  --       --   end
  --       -- end
  --       -- nvim_lsp.tsserver.setup({
  --       --
  --       --   on_attach = on_attach,
  --       --   flags = {
  --       --     debounce_text_changes = 150,
  --       --   },
  --       --   root_dir = function(fname)
  --       --     local project_dir = "/home/anthony/cse160/cse160-assignment4"
  --       --     if fname:sub(1, #project_dir) == project_dir then
  --       --       return project_dir
  --       --     else
  --       --       return nil
  --       --     end
  --       --   end,
  --       -- })
  --
  --       -- WARNING: going to let lazyvim handle the lsp for this instead
  --       -- nvim_lsp.tsserver.setup({
  --       --   on_attach = on_attach,
  --       --   filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  --       --   cmd = { "typescript-language-server", "--stdio" },
  --       -- })
  --     end,
  --   },
  -- },
  -- {}
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
  },

  -- {
  --   "hrsh7th/nvim-cmp",
  --   version = false, -- last release is way too old
  --   -- event = "InsertEnter",
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-path",
  --     "hrsh7th/cmp-cmdline",
  --   },
  --   -- Not all LSP servers add brackets when completing a function.
  --   -- To better deal with this, LazyVim adds a custom option to cmp,
  --   -- that you can configure. For example:
  --   --
  --   -- ```lua
  --   -- opts = {
  --   --   auto_brackets = { "python" }
  --   -- }
  --   -- ```
  --
  --   opts = function()
  --     vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
  --     local cmp = require("cmp")
  --     local defaults = require("cmp.config.default")()
  --     return {
  --       auto_brackets = {}, -- configure any filetype to auto add brackets
  --       completion = {
  --         completeopt = "menu,menuone,noinsert",
  --       },
  --       mapping = cmp.mapping.preset.insert({
  --         ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  --         ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  --         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  --         ["<C-f>"] = cmp.mapping.scroll_docs(4),
  --         ["<C-Space>"] = cmp.mapping.complete(),
  --         ["<C-e>"] = cmp.mapping.abort(),
  --         ["<CR>"] = LazyVim.cmp.confirm(),
  --         ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  --         ["<C-CR>"] = function(fallback)
  --           cmp.abort()
  --           fallback()
  --         end,
  --       }),
  --       sources = cmp.config.sources({
  --         { name = "nvim_lsp" },
  --         { name = "path" },
  --       }, {
  --         { name = "buffer" },
  --       }),
  --       formatting = {
  --         format = function(_, item)
  --           local icons = require("lazyvim.config").icons.kinds
  --           if icons[item.kind] then
  --             item.kind = icons[item.kind] .. item.kind
  --           end
  --           return item
  --         end,
  --       },
  --       experimental = {
  --         ghost_text = {
  --           hl_group = "CmpGhostText",
  --         },
  --       },
  --       sorting = defaults.sorting,
  --     }
  --   end,
  --   ---@param opts cmp.ConfigSchema | {auto_brackets?: string[]}
  --   config = function(_, opts)
  --     for _, source in ipairs(opts.sources) do
  --       source.group_index = source.group_index or 1
  --     end
  --
  --     local parse = require("cmp.utils.snippet").parse
  --     require("cmp.utils.snippet").parse = function(input)
  --       local ok, ret = pcall(parse, input)
  --       if ok then
  --         return ret
  --       end
  --       return LazyVim.cmp.snippet_preview(input)
  --     end
  --
  --     local cmp = require("cmp")
  --     cmp.setup(opts)
  --     cmp.event:on("confirm_done", function(event)
  --       if vim.tbl_contains(opts.auto_brackets or {}, vim.bo.filetype) then
  --         LazyVim.cmp.auto_brackets(event.entry)
  --       end
  --     end)
  --     cmp.event:on("menu_opened", function(event)
  --       LazyVim.cmp.add_missing_snippet_docs(event.window)
  --     end)
  --   end,
  -- },

  -- {
  --   "hrsh7th/nvim-cmp",
  --   version = false, -- last release is way too old
  --   event = "InsertEnter",
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-path",
  --     "hrsh7th/cmp-cmdline",
  --     "L3MON4D3/LuaSnip",
  --     "saadparwaiz1/cmp_luasnip",
  --     "mlaursen/vim-react-snippets",
  --   },
  --   -- Not all LSP servers add brackets when completing a function.
  --   -- To better deal with this, LazyVim adds a custom option to cmp,
  --   -- that you can configure. For example:
  --   --
  --   -- ```lua
  --   -- opts = {
  --   --   auto_brackets = { "python" }
  --   -- }
  --   -- ```
  --
  --   opts = function()
  --     vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
  --     local cmp = require("cmp")
  --     local defaults = require("cmp.config.default")()
  --     local luasnip = require("luasnip")
  --
  --     local compare = cmp.config.compare
  --     return {
  --       luasnip.filetype_extend("typescript", { "tsdoc", "react-ts" }),
  --       auto_brackets = {}, -- configure any filetype to auto add brackets
  --       completion = {
  --         completeopt = "menu,menuone,noinsert",
  --       },
  --       mapping = cmp.mapping.preset.insert({
  --         ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  --         ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  --         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  --         ["<C-f>"] = cmp.mapping.scroll_docs(4),
  --         ["<C-Space>"] = cmp.mapping.complete(),
  --         ["<C-e>"] = cmp.mapping.abort(),
  --         ["<CR>"] = LazyVim.cmp.confirm(),
  --         ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  --         ["<C-CR>"] = function(fallback)
  --           cmp.abort()
  --           fallback()
  --         end,
  --       }),
  --       sources = cmp.config.sources({
  --         { name = "nvim_lsp" },
  --         { name = "path" },
  --       }, {
  --         { name = "buffer" },
  --       }),
  --       formatting = {
  --         format = function(_, item)
  --           local icons = require("lazyvim.config").icons.kinds
  --           if icons[item.kind] then
  --             item.kind = icons[item.kind] .. item.kind
  --           end
  --           return item
  --         end,
  --       },
  --       experimental = {
  --         ghost_text = {
  --           hl_group = "CmpGhostText",
  --         },
  --       },
  --       sorting = defaults.sorting,
  --     }
  --   end,
  --   ---@param opts cmp.ConfigSchema | {auto_brackets?: string[]}
  -- },
  -- {
  --   "nvim-snippets",
  --   enabled = true,
  -- },

  -- {
  --   "nvim-cmp",
  --   dependencies = {
  --     "hrsh7th/cmp-emoji",
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-cmdline",
  --     "L3MON4D3/LuaSnip",
  --     "saadparwaiz1/cmp_luasnip",
  --
  --     "mlaursen/vim-react-snippets",
  --   },
  --   opts = function(_, opts)
  --     table.insert(opts.sources, { name = "emoji" })
  --     require("vim-react-snippets").lazy_load()
  --
  --     local luasnip = require("luasnip")
  --     local cmp = require("cmp")
  --     vim.opt.completeopt = { "menu", "menuone", "noselect" }
  --     -- cmp.setup.cmdline("/", {
  --     --   mapping = cmp.mapping.preset.cmdline(),
  --     --
  --     --   sources = {
  --     --     { name = "buffer" },
  --     --   },
  --     -- })
  --     -- cmp.setup.cmdline(":", {
  --     --
  --     --   mapping = cmp.mapping.preset.cmdline(),
  --     --   sources = cmp.config.sources({
  --     --     { name = "path" },
  --     --   }, { { name = "cmdline" } }),
  --     -- })
  --     opts.mapping = vim.tbl_extend("force", opts.mapping, {
  --       ["<C-j>"] = cmp.mapping(function(fallback)
  --         if cmp.visible() then
  --           cmp.select_next_item()
  --         elseif luasnip.expand_or_jumpable() then
  --           luasnip.expand_or_jump()
  --         elseif has_words_before() then
  --           cmp.complete()
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --       ["<C-k>"] = cmp.mapping(function(fallback)
  --         assert(type(fallback) == "function", "Expected fallback to be a function")
  --         if cmp.visible() then
  --           cmp.select_prev_item()
  --         elseif luasnip.jumpable(-1) then
  --           luasnip.jump(-1)
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --     })
  --   end,
  -- },

  -- Snippet Courtesy of @Zeioth,

  -- {
  --   "L3MON4D3/LuaSnip",
  --   enabled = true,
  --   build = vim.fn.has("win32") ~= 0 and "make install_jsregexp" or nil,
  --   dependencies = {
  --     "rafamadriz/friendly-snippets",
  --     "benfowler/telescope-luasnip.nvim",
  --   },
  --   config = function(_, opts)
  --     if opts then
  --       require("luasnip").config.setup(opts)
  --     end
  --     vim.tbl_map(function(type)
  --       require("luasnip.loaders.from_" .. type).lazy_load()
  --     end, { "vscode", "snipmate", "lua" })
  --     -- friendly-snippets - enable standardized comments snippets
  --     require("luasnip").filetype_extend("typescript", { "tsdoc", "react-ts" })
  --     require("luasnip").filetype_extend("javascript", { "jsdoc", "react" })
  --     require("luasnip").filetype_extend("lua", { "luadoc" })
  --     require("luasnip").filetype_extend("python", { "pydoc" })
  --     require("luasnip").filetype_extend("rust", { "rustdoc" })
  --     require("luasnip").filetype_extend("cs", { "csharpdoc" })
  --     require("luasnip").filetype_extend("java", { "javadoc" })
  --     require("luasnip").filetype_extend("c", { "cdoc" })
  --     require("luasnip").filetype_extend("cpp", { "cppdoc" })
  --     require("luasnip").filetype_extend("php", { "phpdoc" })
  --     require("luasnip").filetype_extend("kotlin", { "kdoc" })
  --     require("luasnip").filetype_extend("ruby", { "rdoc" })
  --     require("luasnip").filetype_extend("sh", { "shelldoc" })
  --   end,
  -- },
}
