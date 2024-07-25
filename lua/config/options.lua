-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = " "

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 0
vim.opt.laststatus = 0
vim.opt.expandtab = true
vim.opt.scrolloff = 5
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = true
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "cursor"
vim.opt.mouse = "a"
vim.opt.cursorline = false
-- Set the clipboard register to a custom register (let's say 'a')
vim.opt.clipboard = "unnamedplus"
-- vim.api.nvim_set_hl(0, "LineNr", { fg = "red", bg = "black" })
-- Disable status line completely
-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })
vim.opt.foldcolumn = "1" -- '0' is not bad
vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.opt.foldenable = false
vim.opt.swapfile = false
-- vim.o.guicursor = "n-v-c-sm-i-ci-ve:block,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
vim.o.guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:block-Cursor2/lCursor2,r-cr:hor20,o:hor50"
-- ver25-

-- - `block`: The cursor is a block that covers the entire cell.
-- - `horizontal`: The cursor is a horizontal bar at the bottom of the cell.
-- - `vertical`: The cursor is a vertical line within the cell.
--
-- You can also specify the cursor style for different modes by appending `-mode_name`, where `mode_name` can be:
--
-- - `n`: Normal mode
-- - `v`: Visual mode
-- - `i`: Insert mode
-- - `c`: Command-line mode
-- - `r`: Replace mode
-- - `o`: Operator-pending mode
--
-- For example, `n:block,i:horizontal` would set the cursor to a block in normal mode and a horizontal bar in insert mode.
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
vim.diagnostic.disable() -- diable diagonstic from the the start can always toggle this
vim.lsp.inlay_hint.enable(false)

-- vim.opt.foldexpr = ""
--
--
--
--
--
--
--
--
--
