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
    -- { import = "lazyvim.plugins.extras.coding.copilot" },
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
    { import = "lazyvim.plugins.extras.lang.python" },
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    -- { import = "lazyvim.plugins.extras.lang.markdown" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    -- {import = "lazyvim.plugins.extras.ui.treesitter-context"}, --ontop will display what function you are in --configured it more in my plugins
    { import = "lazyvim.plugins.extras.coding.mini-surround" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    -- { import = "lazyvim.plugins.extras.coding.codeium" },

    { import = "plugins" },

    -- import any extras modules here
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- import/override with your plugins
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

-- vim.cmd.colorscheme("catppuccin")
vim.cmd.colorscheme("tokyonight")
-- vim.cmd.colorscheme("solarized-osaka")
vim.api.nvim_del_keymap("n", ";c")
-- vim.api.nvim_del_keymap("n", "<C-n>")
-- vim.api.nvim_del_keymap("n", "<C-p>")
-- vim.api.nvim_del_keymap("n", "<space><space>")
-- vim.api.nvim_del_keymap("n", "<leader><leader>")

function LineNumberColors()
  vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#CAF4FF", bold = false })
  vim.api.nvim_set_hl(0, "LineNr", { fg = "white" })
  vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#EEF7FF", bold = false })
end

function FlashColorschemes()
  vim.cmd([[highlight FlashLabel guibg=#FF0000]])
  vim.cmd([[highlight Substitute guibg=#FF0000]])
end

LineNumberColors()
-- FlashColorschemes()

-- NOTE: overide the auto completion settings correctly
-- local cmp = require("cmp")
-- vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- cmp.setup.cmdline("/", {
--   mapping = cmp.mapping.preset.cmdline({}),
--   sources = {
--     { name = "buffer" },
--   },
-- })
-- cmp.setup.cmdline(":", {
--
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = "path" },
--   }, {
--     { name = "cmdline" },
--   }),
-- })
--
-- cmp.setup({
--   mapping = cmp.mapping.preset.insert({
--     ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
--     ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
--     ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--     ["<C-f>"] = cmp.mapping.scroll_docs(4),
--     ["<C-Space>"] = cmp.mapping.complete(),
--     ["<C-e>"] = cmp.mapping.abort(),
--     ["<CR>"] = LazyVim.cmp.confirm(),
--     ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--     ["<C-CR>"] = function(fallback)
--       cmp.abort()
--       fallback()
--     end,
--   }),
-- })

-- local cmp = require("cmp")
-- vim.keymap.set("n", "<C-j>", function()
--   cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })
-- end, default)
--
-- vim.keymap.set("n", "<C-k>", function()
--   cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
-- end, default)

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
