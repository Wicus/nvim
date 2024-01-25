if vim.g.vscode then
	return
end

local keymaps = require("keymaps.core").keymaps
local vim_keymap_set = require("keymaps.core").vim_keymap_set

vim_keymap_set(keymaps.toggle_spellcheck, "<cmd>set invspell<cr>")

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

local function is_quickfix_open()
	for _, win in ipairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then
			return true
		end
	end

	return false
end

-- Quickfix
vim.keymap.set("n", "<localleader>q", function()
	if is_quickfix_open() then
		vim.cmd("cclose")
	else
		vim.cmd("botright copen")
	end
end, { desc = "[Q]uickfix toggle" })
vim.keymap.set("n", "<C-p>", function()
	if is_quickfix_open() then
		vim.cmd("cprevious")
	else
		require("telescope.builtin").find_files()
	end
end, { desc = "<C-p> Find Files" })
vim.keymap.set("n", "<C-n>", function()
	if is_quickfix_open() then
		vim.cmd("cnext")
	end
end)

vim.keymap.set("n", "<leader>zf", function()
	vim.cmd.normal("va}")
	vim.cmd.normal("zf")
end, { desc = "Create bracket {} fold [Z] [F]old" })

vim.keymap.set("n", "<leader>tn", vim.cmd.tabNext, { desc = "Next tab" })
