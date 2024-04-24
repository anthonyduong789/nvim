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
keymap.set("i", "<C-h>", "<Left>", { noremap = true, silent = true })
keymap.set("i", "<C-l>", "<Right>", { noremap = true, silent = true })

-- Split window
keymap.set("n", "<Leader>ws", ":split<Return>", opts)
keymap.set("n", "<Leader>wv", ":vsplit<Return>", opts)

keymap.set("n", "<Leader>tt", function()
  vim.cmd("tabnew")
  vim.cmd("terminal")
  vim.cmd("setlocal nonumber norelativenumber") -- Turn off line numbers for this tab
  vim.cmd("startinsert")
end, { desc = "terminal new tab" })

keymap.set("n", "<Leader>tl", function()
  vim.cmd("tabnew")
  vim.cmd("terminal")
  vim.cmd("setlocal nonumber norelativenumber") -- Turn off line numbers for this tab
  vim.cmd("startinsert")

  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("live-server<CR>", true, false, true), "t", false)
end, { desc = "new tab live-server" })

keymap.set("n", "<Leader>tc", function()
  local cmd = vim.fn.input("terminal command: ")
  if cmd ~= "" then
    vim.cmd("tabnew")
    vim.cmd("setlocal nonumber norelativenumber")
    vim.cmd("terminal")
    vim.cmd("startinsert")
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(cmd .. "<CR>", true, false, true), "t", false)
  end
end, { desc = "custom command" })

-- vim.api.nvim_set_keymap(
--   "n",
--   "<leader>tc",
--   "<cmd>lua RunCustomCommandInTerminal()<CR>",
--   { noremap = true, silent = true }
-- )

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)

keymap.set("n", "<C-o>", function()
  local current_file_path = vim.fn.expand("%:p")
  print(current_file_path)
end, opts)

-- vim.api.nvim_set_keymap("n", "H", "<cmd>lua vim.lsp.buf.hover()<cr>", { noremap = true })
-- vim.api.nvim_set_keymap("n", "J", "<Plug>(easymotion-w)", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "K", "<Plug>(easymotion-b)", { noremap = true, silent = true })
