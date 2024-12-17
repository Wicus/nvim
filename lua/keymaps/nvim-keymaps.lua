if vim.g.vscode then
	return
end

local utils = require("keymaps.utils")
local keymaps = require("keymaps.core").keymaps
local vim_keymap_set = require("keymaps.core").vim_keymap_set

vim_keymap_set(keymaps.toggle_spellcheck, "<cmd>set invspell<cr>")
vim_keymap_set(keymaps.toggle_wrap, "<cmd>set wrap!<cr>")
vim_keymap_set(keymaps.toggle_highlight, "<cmd>nohlsearch<cr>")

-- Search and replace commands
vim_keymap_set(keymaps.search_change_goto_next, function() vim.fn.feedkeys("*Ncgn") end)

-- Diagnostic keymaps
vim_keymap_set(keymaps.diagnostics_help, vim.diagnostic.open_float)
vim_keymap_set(keymaps.diagnostics_next, vim.diagnostic.goto_next)
vim_keymap_set(keymaps.diagnostics_prev, vim.diagnostic.goto_prev)
vim_keymap_set(keymaps.error_next, function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity["ERROR"] }) end)
vim_keymap_set(keymaps.error_prev, function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity["ERROR"] }) end)
vim_keymap_set(keymaps.warning_next, function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity["WARN"] }) end)
vim_keymap_set(keymaps.warning_prev, function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity["WARN"] }) end)
vim_keymap_set(keymaps.toggle_diagnostics, function()
	if vim.diagnostic.is_disabled() then
		vim.diagnostic.enable()
	else
		vim.diagnostic.disable()
	end
end)

vim_keymap_set(keymaps.toggle_quickfix, function()
	if utils.is_quickfix_open() then
		vim.cmd("cclose")
	else
		vim.cmd("botright copen")
	end
end)

vim_keymap_set(keymaps.find_files, require("telescope.builtin").find_files)

-- vim_keymap_set(keymaps.previous_entry, function()
-- 	if utils.is_quickfix_open() then
-- 		vim.cmd("cprevious")
-- 	end
-- end)
--
-- vim_keymap_set(keymaps.next_entry, function()
-- 	if utils.is_quickfix_open() then
-- 		vim.cmd("cnext")
-- 	end
-- end)

vim_keymap_set(keymaps.fold_bracket, function()
	vim.cmd("normal va}")
	vim.cmd("normal zf")
end)

vim.keymap.set("n", "]]", "<cmd>cnext<cr>", { desc = "Next quickfix item" })
vim.keymap.set("n", "[[", "<cmd>cprev<cr>", { desc = "Previous quickfix item" })

vim.keymap.set("n", "]t", "<cmd>tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "[t", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
