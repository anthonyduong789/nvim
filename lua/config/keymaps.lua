-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "x", '"_x')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save file and quit
keymap.set("n", "<Leader>w", ":update<Return>", opts)
keymap.set("n", "<Leader>q", ":quit<Return>", opts)
keymap.set("n", "<Leader>Q", ":qa<Return>", opts)

-- File explorer with NvimTree
-- keymap.set("n", "<Leader>f", ":NvimTreeFindFile<Return>", opts)
-- keymap.set("n", "<Leader>t", ":NvimTreeToggle<Return>", opts)

-- Tabs
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
keymap.set("n", "tw", ":tabclose<Return>", opts)
keymap.set("n", "<Leader>nt", function()
  local telescope = require("telescope")

  local function telescope_buffer_dir()
    return vim.fn.expand("%:p:h")
  end
  vim.cmd("tabnew")
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = false,
    initial_mode = "normal",
    layout_config = { height = 40 },
  })
end, opts)

keymap.set("i", "<C-h>", "<Left>", { noremap = true, silent = true })
keymap.set("i", "<C-l>", "<Right>", { noremap = true, silent = true })

-- Split window
keymap.set("n", "<Leader>wsh", ":split<Return>", opts)
keymap.set("n", "<Leader>wsv", ":vsplit<Return>", opts)

keymap.set("n", "T", ":TagbarToggle<Return>", opts)

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)
