local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "lazyvim.plugins.extras.linting.eslint" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    { import = "lazyvim.plugins.extras.coding.copilot" },
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
    { import = "lazyvim.plugins.extras.lang.python" },

    { import = "plugins" },

    -- import any extras modules here
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  -- install = { colorscheme = { "tokyonight", "habama" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- put he customizations here because it overides the default ones
vim.api.nvim_set_hl(0, "LineNr", { ctermfg = "white" })
-- Setup key mappings using Lua
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>ff",
  ":lua require('telescope.builtin').find_files({ cwd = vim.fn.expand('~') })<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>fb",
  "<cmd>lua require('telescope.builtin').buffers()<CR>",
  { noremap = true, silent = true }
)

vim.cmd.colorscheme("catppuccin-mocha")
-- -- Set the background color to be transparent or inherit from the terminal
vim.cmd([[
    highlight CursorLine cterm=none ctermbg=NONE gui=none guibg=NONE
]])
--
--   highlight Comment ctermfg=14 cterm=bold guifg=#00ffff gui=bold
-- highlight Normal ctermfg=15 ctermbg=235 guifg=#ffffff guibg=#1c1c1c
--     hi Normal guibg=NONE ctermbg=NONE
--     hi NonText guibg=NONE ctermbg=NONE
-- -- Optional: Ensure that background transparency is respected in additional highlighting
-- vim.cmd([[
--     hi VertSplit guibg=NONE ctermbg=NONE
--     hi SignColumn guibg=NONE ctermbg=NONE
--     hi NormalNC guibg=NONE ctermbg=NONE ]]) vim.api.nvim_set_keymap("n", "J", "<Plug>(easymotion-bd-w)", { noremap = true, silent = true })
-- Sets colors to line numbers Above, Current and Below  in this order
-- vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#F5DAD2", bold = true })
function LineNumberColors()
  vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#F5DAD2", bold = false })
  vim.api.nvim_set_hl(0, "LineNr", { fg = "white", bold = true })
  vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#F5DAD2", bold = false })
end
LineNumberColors()
local cmp = require("cmp")
vim.opt.completeopt = { "menu", "menuone", "noselect" }
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline({}),
  sources = {
    { name = "buffer" },
  },
})
cmp.setup.cmdline(":", {

  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

require("telescope").setup({
  defaults = {
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        -- Width of the Telescope window as a percentage of total screen width
        width = 0.999,
        -- Width of the preview window as a percentage of the Telescope window width
        preview_width = 0.6,
        -- Height of the Telescope window as a percentage of total screen height
        height = 0.999,
        prompt_position = "top",
      },
      vertical = {
        width = 0.9,
        height = 0.55,
        preview_height = 0.4,
        prompt_position = "top",
      },
    },
  },
})
