-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
--
vim.cmd([[
  autocmd InsertLeave,TextChanged,TextChangedI * silent! update
  autocmd FocusLost * silent! update
]])

-- Define a custom highlight group for insert mode in NeoTree
vim.api.nvim_exec(
  [[
  highlight NeoTreeInsertMode guifg=#FFD700
]],
  false
)

-- Autocommands to change color when entering and leaving insert mode in NeoTree
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "neo-tree" then
      vim.api.nvim_command("highlight link NeoTreeNormal NeoTreeInsertMode")
    end
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "neo-tree" then
      vim.api.nvim_command("highlight link NeoTreeNormal Normal")
    end
  end,
})
