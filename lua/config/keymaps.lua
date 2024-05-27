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

-- Split window
keymap.set("n", "<Leader>ws", ":split<Return>", opts)
keymap.set("n", "<Leader>wv", ":vsplit<Return>", opts)

-- motin mappings
keymap.set("i", "<C-h>", "<Left>", { noremap = true, silent = true })
keymap.set("i", "<C-l>", "<Right>", { noremap = true, silent = true })
keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
-- copy to clipboard
keymap.set("v", "<C-y>", '"+y', { noremap = true, silent = true })
-- delete and wont go to yank register
keymap.set("v", "<C-d>", '"-d', { noremap = true, silent = true })

-- NOTE:CopilotChat keymaps
keymap.set("v", "<Leader>00d", function()
  local input_text = "give me a concise explanatioon of the code with a list that is similar to a doc explanation"
  if input_text ~= "" then
    require("CopilotChat").ask(input_text, { selection = require("CopilotChat.select").visual })
  end
end, { noremap = true, silent = true, desc = "Short doc explanation" })
keymap.set("v", "<Leader>0c", function()
  local input_text = vim.fn.input("question about selected code: ")
  if input_text ~= "" then
    require("CopilotChat").ask(input_text, { selection = require("CopilotChat.select").visual })
  end
end, { noremap = true, silent = true, desc = "question about this code" })
keymap.set("n", "<Leader>0c", function()
  local input_text = vim.fn.input("CopilotChat ?: ")
  if input_text ~= "" then
    require("CopilotChat").ask(input_text)
  end
end, { noremap = true, silent = true, desc = "CopilotChat ?" })
keymap.set(
  "n",
  "<Leader>0t",
  ":CopilotChatToggle<Return>",
  { noremap = true, silent = true, desc = "CopilotChatToggle" }
)

keymap.set("v", "<Leader>0e", ":CopilotChatExplain ", { noremap = true, silent = true, desc = "CopilotChatExplain" })
keymap.set("v", "<Leader>0d", ":CopilotChatDocs<Return>", { noremap = true, silent = true, desc = "CopilotChatDocs" })
keymap.set(
  "v",
  "<Leader>0o",
  ":CopilotChatOptimize<Return>",
  { noremap = true, silent = true, desc = "CopilotChatOptimize" }
)
keymap.set("v", "<Leader>0p", function()
  local actions = require("CopilotChat.actions")
  require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
end, { noremap = true, silent = true, desc = "CopilotChat actions" })
keymap.set("n", "<Leader>0p", function()
  local actions = require("CopilotChat.actions")
  require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
end, { noremap = true, silent = true, desc = "CopilotChat actions" })

keymap.set("n", "<Leader>0q", function()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
  end
end, { noremap = true, silent = true, desc = "quick chat current buffer" })

-- --------------------------------------------------------------------------------------------------V

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

keymap.set("n", "<Leader>md", function()
  vim.cmd("MarkdownPreview")
end, { desc = "View your markdown file" })

local custom_words = { "useState", "useEffect", "use", "className" }

vim.api.nvim_set_keymap("n", "<Leader>fs", "", {
  noremap = true,
  callback = function()
    local finders = require("telescope.finders")
    local pickers = require("telescope.pickers")
    local previewers = require("telescope.previewers")
    local conf = require("telescope.config").values

    local current_file = vim.fn.expand("%:p")
    local word_occurrences = {}
    -- Function to get all occurrences of the custom words in the current file
    local function get_word_occurrences()
      for _, word in ipairs(custom_words) do
        local cmd = "rg --vimgrep --no-heading --line-number --column " .. word .. " " .. current_file
        local results = vim.fn.systemlist(cmd)
        for _, result in ipairs(results) do
          table.insert(word_occurrences, result)
        end
      end
    end

    get_word_occurrences()

    pickers
      .new({}, {
        prompt_title = "Search Custom Words in Current File",
        finder = finders.new_table({
          results = word_occurrences,
          entry_maker = function(entry)
            local split_entry = vim.split(entry, ":")
            return {
              value = entry,
              display = string.format("%d:%d: %s", tonumber(split_entry[2]), tonumber(split_entry[3]), split_entry[4]),
              ordinal = entry,
              filename = split_entry[1],
              lnum = tonumber(split_entry[2]),
              col = tonumber(split_entry[3]),
              text = split_entry[4],
            }
          end,
        }),
        sorter = conf.generic_sorter({}),
        previewer = previewers.new_buffer_previewer({
          define_preview = function(self, entry, status)
            local bufnr = self.state.bufnr
            local lnum = entry.lnum
            local lines = vim.fn.getline(lnum, lnum + 10)
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
            vim.api.nvim_buf_add_highlight(bufnr, -1, "Search", 0, 0, -1)
            vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
          end,
        }),
        attach_mappings = function(_, map)
          map("i", "<CR>", function(prompt_bufnr)
            local entry = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
            require("telescope.actions").close(prompt_bufnr)
            vim.cmd(string.format("edit %s", entry.filename))
            vim.fn.cursor(entry.lnum, entry.col)
          end)
          return true
        end,
      })
      :find()
  end,
  desc = "grep custom words in current file",
})

-- vim.api.nvim_set_keymap("n", "gx", ":lua OpenLinkUnderCursor()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "gx", ":lua OpenLinkUnderCursor()<CR>", { noremap = true, silent = true })

function OpenLinkUnderCursor()
  local url = vim.fn.expand("<cWORD>")
  if string.match(url, "^http") then
    os.execute("open " .. url) -- Use 'xdg-open' for Linux
  else
    print("Not a valid URL")
  end
end

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "gd", "<Cmd>Lspsaga lsp_finder<CR>", opts)
vim.keymap.set("i", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", opts)
vim.keymap.set("n", "gp", "<Cmd>Lspsaga preview_definition<CR>", opts)
vim.keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
