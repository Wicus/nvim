if vim.g.vscode then
	return
end

local keymaps = require("keymaps.core").keymaps
local vim_keymap_set = require("keymaps.core").vim_keymap_set

vim_keymap_set(keymaps.toggle_spellcheck, "<cmd>set invspell<cr>")

-- Search and replace commands
vim_keymap_set(keymaps.search_change_goto_next, function() vim.fn.feedkeys("*Ncgn") end)

-- Diagnostic keymaps
vim.keymap.set("n", "gh", vim.diagnostic.open_float, { desc = "[G]oto diagnostic [H]elp: List diagnostic under cursor" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous [D]iagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next [D]iagnostic" })
vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity["ERROR"] }) end, { desc = "Previous [E]rror" })
vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity["ERROR"] }) end, { desc = "Next [E]rror" })
vim.keymap.set("n", "[w", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity["WARN"] }) end, { desc = "Previous [W]arning" })
vim.keymap.set("n", "]w", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity["WARN"] }) end, { desc = "Next [W]arning" })
vim.keymap.set("n", "<leader>ud", function()
	if vim.diagnostic.is_disabled() then
		vim.diagnostic.enable()
	else
		vim.diagnostic.disable()
	end
end, { desc = "Toggle diagnostics" })

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
