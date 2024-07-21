return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- tag = "v0.9.1",
    opts = {

      ensure_installed = {
        "javascript",
        "typescript",
        "css",
        "gitignore",
        "graphql",
        "http",
        "json",
        "scss",
        "sql",
        "vim",
        "lua",
        "html",
        "python",
        "tsx",
        "markdown",
        "markdown_inline",
      },

      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
      highlight = { enable = false },
      indent = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["ii"] = "@conditional.inner",
            ["ai"] = "@conditional.outer",
            ["il"] = "@loop.inner",
            ["al"] = "@loop.outer",
            ["at"] = "@comment.outer",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
            ["]a"] = "@parameter.inner",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[a"] = "@parameter.inner",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      -- MDX
      vim.filetype.add({
        extension = {
          mdx = "mdx",
          jsx = "javascriptreact",
          tsx = "typescriptreact", -- This assumes the 'typescript.tsx' parser is properly set up in Treesitter
        },
      })
      vim.treesitter.language.register("markdown", "mdx")

      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
    end,
  },
  {},
}
-- require("nvim-treesitter.configs").setup({
--   -- Add languages to be installed here that you want installed for treesitter
--   ensure_installed = {
--     "go",
--     "lua",
--     "python",
--     "rust",
--     "typescript",
--     "regex",
--     "bash",
--     "markdown",
--     "markdown_inline",
--     "kdl",
--     "sql",
--     "org",
--     "terraform",
--     "html",
--     "css",
--     "javascript",
--     "yaml",
--     "json",
--     "toml",
--   },
--
--   highlight = { enable = true },
--   indent = { enable = true },
--   incremental_selection = {
--     enable = true,
--     keymaps = {
--       init_selection = "<c-space>",
--       node_incremental = "<c-space>",
--       scope_incremental = "<c-s>",
--       node_decremental = "<c-backspace>",
--     },
--   },
--   textobjects = {
--     select = {
--       enable = true,
--       lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
--       keymaps = {
--         -- You can use the capture groups defined in textobjects.scm
--         ["aa"] = "@parameter.outer",
--         ["ia"] = "@parameter.inner",
--         ["af"] = "@function.outer",
--         ["if"] = "@function.inner",
--         ["ac"] = "@class.outer",
--         ["ic"] = "@class.inner",
--         ["ii"] = "@conditional.inner",
--         ["ai"] = "@conditional.outer",
--         ["il"] = "@loop.inner",
--         ["al"] = "@loop.outer",
--         ["at"] = "@comment.outer",
--       },
--     },
--     move = {
--       enable = true,
--       set_jumps = true, -- whether to set jumps in the jumplist
--       goto_next_start = {
--         ["]f"] = "@function.outer",
--         ["]]"] = "@class.outer",
--       },
--       goto_next_end = {
--         ["]F"] = "@function.outer",
--         ["]["] = "@class.outer",
--       },
--       goto_previous_start = {
--         ["[f"] = "@function.outer",
--         ["[["] = "@class.outer",
--       },
--       goto_previous_end = {
--         ["[F"] = "@function.outer",
--         ["[]"] = "@class.outer",
--       },
--     },
--     swap = {
--       enable = true,
--       swap_next = {
--         ["<leader>a"] = "@parameter.inner",
--       },
--       swap_previous = {
--         ["<leader>A"] = "@parameter.inner",
--       },
--     },
--   },
-- })
