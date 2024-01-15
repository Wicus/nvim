if vim.g.vscode then
	return
end

-- Toggle commands
vim.keymap.set("n", "<leader>us", "<cmd>set invspell<cr>", { desc = "Toggle Spellcheck" })

-- Search and replace commands
vim.keymap.set({ "n", "x" }, "<leader>cgn", function() vim.fn.feedkeys("*Ncgn") end, { desc = "Search and change work under cursor (cgn)" })

-- Stay in visual mode after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Resize window
vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<cr>")
vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<cr>")
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize -2<cr>")
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize +2<cr>")

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
