-- Do nothing when pressing space
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Pasting will not replace the current register with what is selected
vim.keymap.set("x", "p", '"_dP')

-- Copy to system clipboard
vim.keymap.set("x", "<C-c>", '"+y')

-- Move lines up and down with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keeps cursor on the same spot on K
vim.keymap.set("n", "J", "mzJ`z")

-- Keep centered while scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "*", "*zzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]], { desc = "Move to above window" })

-- Stay in visual mode after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Resize window
vim.keymap.set("n", "<C-Left>", "<c-w>5<")
vim.keymap.set("n", "<C-Right>", "<c-w>5>")
vim.keymap.set("n", "<C-Up>", "<C-W>+")
vim.keymap.set("n", "<C-Down>", "<C-W>-")

-- Remove highligh on Escape
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")

-- Execute lua code
vim.keymap.set("n", "<leader>rf", "<cmd>source %<cr>", { desc = "Reload (Source) file" })
vim.keymap.set("v", "<leader>r", ":lua<cr>", { desc = "Reload (Execute lua)" })
vim.keymap.set("n", "<leader>r", "<cmd>.lua<cr>", { desc = "Reload (Execute lua)" })

-- Spelling
vim.keymap.set("n", "<leader>us", "<cmd>set invspell<cr>", { desc = "Spelling" })

-- Tab navigation
vim.keymap.set("n", "]t", "<cmd>tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "[t", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
