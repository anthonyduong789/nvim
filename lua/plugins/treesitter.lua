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
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
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
    end,
  },
}
