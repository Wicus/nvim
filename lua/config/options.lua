vim.opt.laststatus = 3 -- Always show statusline

-- Sane defaults for tabs and spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Set highlight on search to false
vim.opt.hlsearch = true

-- Make line numbers default
vim.wo.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true -- Highlight current line

-- Enable break indent
vim.opt.breakindent = true

-- Enable / Disable backup files
vim.opt.swapfile = false
vim.opt.backup = true
vim.opt.backupdir = vim.fn.expand("~/nvim-new-backup-folder")

-- Save undo history
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 50

-- Set colorscheme
vim.opt.background = "dark"
vim.opt.termguicolors = true

-- Set completeopt to have a better completion experience
vim.opt.completeopt = "menu,menuone,noselect"

-- Color column
vim.opt.colorcolumn = "160"

-- Spelling
vim.opt.spell = false
vim.opt.spelllang = "en_us"

-- Clipboard
-- vim.opt.clipboard = "unnamedplus"

-- Always show the signcolumn, otherwise it would shift the text each time
vim.wo.signcolumn = "yes"

-- We don't need to see things like -- INSERT -- anymore
vim.opt.showmode = false

-- Better splits when opening buffers
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Set guifont
vim.opt.guifont = "Consolas:h9"

-- Line wrap
vim.opt.wrap = false

-- File Format
vim.opt.fileformat = "unix"

--  Set unknown filetypes
vim.filetype.add({ extension = { axaml = "xml" } })

-- <EOL> at the end of file will be restored if missing
vim.opt.fixendofline = false
