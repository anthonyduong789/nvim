-- return {
--   { "craftzdog/solarized-osaka.nvim" },
--   -- Configure LazyVim to load gruvbox
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "solarized-osaka",
--     },
--   },
-- }
-- --
-- return {
--   -- add gruvbox
--   { "ellisonleao/gruvbox.nvim" },
--
--   -- Configure LazyVim to load gruvbox
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "gruvbox",
--     },
--   },
-- }
--
--
--
--
return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      transparent = false,
      styles = {
        floats = "transparent",
        sidebars = "transparent",
      },
    },
  },
  {

    "ellisonleao/gruvbox.nvim",
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = false,
      integrations = {
        leap = true,
        telescope = true,
        harpoon = true,
        mason = true,
        neotest = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
  {
    "craftzdog/solarized-osaka.nvim",
    branch = "osaka",
    lazy = true,
    priority = 1000,
    opts = function()
      return {
        transparent = false,
        leap = true,
        telescope = true,
        harpoon = true,
        mason = true,
        neotest = true,
      }
    end,
  },
}

-- return {
-- }
-- return {}
