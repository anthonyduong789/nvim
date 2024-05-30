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

keymap.set("n", "<Leader>te", function()
  local current_tab = vim.fn.tabpagenr()
  vim.cmd("tabnew")
  vim.cmd("terminal")
  vim.cmd("setlocal nonumber norelativenumber") -- Turn off line numbers for this tab
  terminal_channel_id = vim.b.terminal_job_id -- Store the terminal's job ID
  -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("live-server<CR>", true, false, true), "t", false)
  send_command_to_terminal("fe")
  vim.cmd(current_tab .. "tabnext")
end, { desc = "new tab live-server" })

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
vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "gd", "<Cmd>Lspsaga lsp_finder<CR>", opts)
vim.keymap.set("i", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", opts)
vim.keymap.set("n", "gp", "<Cmd>Lspsaga peek_definition<CR>", opts)
vim.keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)

-- Define a list of commands
local LspSagaCmds = {
  { desc = "doc 📄", cmd = ":Lspsaga hover_doc" },
  { desc = "Show code action 🤖", cmd = ":Lspsaga code_action" },
  { desc = "Show line diagnostics", cmd = ":Lspsaga show_line_diagnostics" },
  { desc = "Diagnostic jump forward", cmd = ":Lspsaga diagnostic_jump_next" },
  { desc = "Diagnostic jump backward", cmd = ":Lspsaga diagnostic_jump_prev" },
  { desc = "rename ✍️", cmd = ":Lspsaga rename" },
  { desc = "peek_definition 🔍", cmd = ":Lspsaga peek_definition" },
  { desc = "peek type definition 🔤", cmd = ":Lspsaga peek_type_definition" },
  { desc = "type definition🔤", cmd = ":Lspsaga goto_type_definition" },
  { desc = "references & Implementations 🌳", cmd = ":Lspsaga finder" },
  { desc = "floating terminal💻", cmd = ":Lspsaga term_toggle" },
  { desc = "outline 🎄", cmd = ":Lspsaga outline" },
  { desc = "windbar toggle⬆️", cmd = ":Lspsaga winbar_toggle" },
  { desc = "workspace diagnostics☹️", cmd = ":Lspsaga show_buf_diagnostics" },
  { desc = "incoming calls 📲 ", cmd = ":Lspsaga incoming_calls" },
  { desc = "outgoing calls 🔈", cmd = ":Lspsaga outgoing_calls" },
}

-- Function to execute the selected command
function execute_command(prompt_bufnr)
  local entry = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
  require("telescope.actions").close(prompt_bufnr)
  vim.cmd(entry.value.cmd)
end

-- Custom Telescope picker with layout customization
function command_picker(tableList)
  require("telescope.pickers")
    .new({}, {
      prompt_title = "Lspsaga/lsp commands",
      finder = require("telescope.finders").new_table({
        results = tableList,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry.desc,
            ordinal = entry.desc,
          }
        end,
      }),
      sorter = require("telescope.config").values.generic_sorter({}),
      attach_mappings = function(_, map)
        map("i", "<CR>", execute_command)
        map("n", "<CR>", execute_command)
        return true
      end,
      layout_strategy = "vertical",
      layout_config = {
        width = 0.5,
        height = 0.4,
        preview_cutoff = 1, -- Preview window disabled
        prompt_position = "top",
        anchor = "N",
      },
      borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      border = true,
    })
    :find()
end

function command_pickerLspSaga()
  command_picker(LspSagaCmds)
end

-- Key mapping to open the custom picker
vim.api.nvim_set_keymap(
  "n",
  "\\c",
  "<Cmd>lua command_pickerLspSaga()<CR>",
  { noremap = true, silent = true, desc = "Lspsaga commands/lsp" }
)
local floating_window = {
  buf = nil,
  win = nil,
}

function OpenNotes(notes)
  if floating_window.win and vim.api.nvim_win_is_valid(floating_window.win) then
    -- Close the floating window if it is already open
    vim.api.nvim_win_close(floating_window.win, true)
    floating_window.win = nil
    floating_window.buf = nil
  else
    -- Define the path to the Markdown file you want to edit
    -- local notesFolder = "~/.config/nvim/Notes/" .. tostring(v)
    local notesFolder = "~/.config/nvim/Notes/" .. tostring(notes)
    vim.api.nvim_out_write(notesFolder)
    print(notesFolder)

    local file_path = vim.fn.expand(notesFolder)

    -- Create or open the file buffer
    local buf = vim.fn.bufadd(file_path)

    vim.fn.bufload(buf)

    -- Calculate the window size
    local max_width = 130
    local width = math.min(math.floor(vim.o.columns * 0.9), max_width)
    local max_height = 25 -- replace with your desired maximum heightke
    local height = math.min(math.floor(vim.o.lines * 0.9), max_height)
    local row = math.floor((vim.o.lines - height) / 4)
    -- local row =
    local col = math.floor((vim.o.columns - width) / 2)

    -- Create the floating window
    local win = vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = width,
      height = height,
      col = col,
      row = 0,
      border = "double",
      title = "***---" .. tostring(notes) .. "---🐱 ***",
      title_pos = "center",

      -- border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },

      zindex = 10, -- Set a lower z-indexn
    })

    -- Set the FloatBorder highlight group
    -- local ns_id = vim.api.nvim_create_namespace("PersonalNotes")
    vim.api.nvim_set_hl(0, "PersonalNotesBorder", {
      fg = "#E1AFD1", -- Red foreground
    })
    vim.api.nvim_win_set_option(win, "winhl", "FloatBorder:PersonalNotesBorder")

    vim.api.nvim_win_set_option(win, "cursorline", true) -- Highlight the line of the cursor
    -- vim.api.nvim_win_set_option(win, "cursorcolumn", true) -- Highlight the column of the cursor

    -- Set buffer options
    vim.api.nvim_buf_set_option(buf, "buftype", "")
    vim.api.nvim_buf_set_option(buf, "bufhidden", "hide")
    vim.api.nvim_buf_set_option(buf, "filetype", "markdown")

    -- Set window options
    vim.api.nvim_win_set_option(win, "cursorline", true)
    vim.api.nvim_win_set_option(win, "relativenumber", true)

    -- Save the buffer and window to the floating_window table

    floating_window.buf = buf
    floating_window.win = win
  end
end

local notes = {}

-- local path = "~/.config/nvim/Notes/"

function insert_files_in_path()
  local path = vim.fn.expand("~/.config/nvim/Notes/") -- expand the tilde to the full path
  local files = {
    "nvimHelp.md",
    "notes.md",
    "nvimApiLuaNotes.md",
  }

  local function file_exists(file)
    for _, existing_file in ipairs(files) do
      if existing_file == file then
        return true
      end
    end
    return false
  end
  -- List all files in the directory
  ---- List all files in the directory
  local handle = io.popen('ls "' .. path .. '"')
  if handle then
    for file in handle:lines() do
      if not file_exists(file) then
        table.insert(files, file)
      end
    end
    handle:close()
  else
    print("Error: Unable to open path " .. path)
  end

  return files
end

notes = insert_files_in_path()
-- for file in lfs.dir(path) do
--   if file ~= "." and file ~= ".." then -- exclude these special directories
--     local f = path .. "/" .. file
--     local attr = lfs.attributes(f)
--     if attr.mode == "file" then -- only add if it's a file
--       table.insert(files, f)
--     end
--   end
-- end

vim.api.nvim_command("command! -nargs=1 OpenNotes lua OpenNotes(<f-args>)")

-- Key mapping to toggle the floating window
for i, note in ipairs(notes) do
  vim.api.nvim_set_keymap(
    "n",
    "\\\\" .. i,
    ":lua OpenNotes('" .. note .. "')<CR>",
    { noremap = true, silent = true, desc = note }
  )
  -- - vim.api.nvim_set_keymap(
end
--   "n",
--   "\\\\m",
--   ":lua OpenNotes('notes.md')<CR>",
--   { noremap = true, silent = true, desc = "personal note" }
-- )
