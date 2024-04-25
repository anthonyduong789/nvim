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

-- saves terminal id to sent to later
local terminal_channel_id = nil
-- Function to send commands to the terminal
function send_command_to_terminal(command)
  if terminal_channel_id then
    if command == "stop" then
      -- Send the Ctrl-C character (ASCII 0x03)
      vim.fn.chansend(terminal_channel_id, "\x03")
    elseif command == "nrd" then
      vim.fn.chansend(terminal_channel_id, "npm run dev" .. "\n")
    else
      vim.fn.chansend(terminal_channel_id, command .. "\n")
    end
  else
    print("Terminal not started")
  end
end

keymap.set("n", "<Leader>tt", function()
  local current_tab = vim.fn.tabpagenr()
  vim.cmd("tabnew")
  vim.cmd("terminal")
  vim.cmd("setlocal nonumber norelativenumber") -- Turn off line numbers for this tab
  terminal_channel_id = vim.b.terminal_job_id -- Store the terminal's job ID

  vim.cmd(current_tab .. "tabnext")
end, { desc = "terminal new tab silently" })

keymap.set("n", "<Leader>tl", function()
  local current_tab = vim.fn.tabpagenr()
  vim.cmd("tabnew")
  vim.cmd("terminal")
  vim.cmd("setlocal nonumber norelativenumber") -- Turn off line numbers for this tab
  terminal_channel_id = vim.b.terminal_job_id -- Store the terminal's job ID
  -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("live-server<CR>", true, false, true), "t", false)
  send_command_to_terminal("live-server")
  vim.cmd(current_tab .. "tabnext")
end, { desc = "new tab live-server" })

keymap.set("n", "<Leader>tc", function()
  local cmd = vim.fn.input("Enter the terminal command: ")
  if cmd ~= "" then
    send_command_to_terminal(cmd)
  end
end, { desc = "send command to terminal" })

-- Diagnostics
-- keymap.set("n", "<C-j>", function()
--   vim.diagnostic.goto_next()
-- end, opts)
--
-- keymap.set("n", "<C-o>", function()
--   local current_file_path = vim.fn.expand("%:p")
--   print(current_file_path)
-- end, opts)
