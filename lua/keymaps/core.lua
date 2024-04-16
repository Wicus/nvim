-- Do nothing when pressing space
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
vim.keymap.set("n", "j", 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })

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

-- Stay in visual mode after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Resize window
vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<cr>")
vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<cr>")
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize -2<cr>")
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize +2<cr>")

-- Remove highligh on Escape
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")

-- All keymaps are defined here
local keymaps = {
	-- Global
	paste = { mode = { "n", "x" }, keymap = "<C-v>", desc = "Paste" },
	explorer = { mode = "n", keymap = "-", desc = "Open explorer" },
	qflist_toggle = { mode = "n", keymap = "<localleader>q", desc = "Toggle quickfix list" },
	source_config = { mode = "n", keymap = "<leader>so", desc = "Source config" },

	-- Diagnostics
	diagnostics_help = { mode = "n", keymap = "gh", desc = "Diagnostics help" },
	diagnostics_next = { mode = "n", keymap = "]d", desc = "Go to next diagnostics" },
	diagnostics_prev = { mode = "n", keymap = "[d", desc = "Go to prev diagnostics" },
	error_next = { mode = "n", keymap = "]e", desc = "Go to next error" },
	error_prev = { mode = "n", keymap = "[e", desc = "Go to prev error" },
	warning_next = { mode = "n", keymap = "]w", desc = "Go to next warning" },
	warning_prev = { mode = "n", keymap = "[w", desc = "Go to prev warning" },

	-- Formatting
	format_selection_n = { mode = "n", keymap = "==", desc = "Format selection" },
	format_selection_v = { mode = "v", keymap = "=", desc = "Format selection" },

	-- Grep
	live_grep_n = { mode = "n", keymap = "<leader>/", desc = "Live grep" },
	live_grep_v = { mode = "v", keymap = "<leader>*", desc = "Live grep current word" },
	live_grep_selection = { mode = "v", keymap = "<leader>*", desc = "Live grep selection" },

	-- Copilot / GPT chat
	chat = { mode = { "n", "x" }, keymap = "<leader>ch", desc = "Open chat" },
	chat_inline = { mode = { "n", "x" }, keymap = "<leader>ci", desc = "Quick chat" },
	chat_list = { mode = { "n", "x" }, keymap = "<leader>cl", desc = "Inline chat" },
	copilot_chat_buffer = { mode = "n", keymap = "<leader>ccb", desc = "Chat with current buffer" },
	copilot_chat_explain = { mode = "n", keymap = "<leader>cce", desc = "Explain code" },
	copilot_chat_tests = { mode = "n", keymap = "<leader>cct", desc = "Generate tests" },
	copilot_chat_vsplit_toggle = { mode = "n", keymap = "<leader>ccT", desc = "Toggle vertical split" },
	copilot_chat_visual = { mode = "x", keymap = "<leader>ccv", desc = "Open in vertical split" },
	copilot_chat_in_place = { mode = "x", keymap = "<leader>ccx", desc = "Run in-place code" },
	copilot_chat_fix_diagnostic = { mode = "n", keymap = "<leader>ccf", desc = "Fix diagnostic" },
	copilot_chat_reset = { mode = "n", keymap = "<leader>ccr", desc = "Reset chat history and clear buffer" },

	-- Buffers
	buffers = { mode = "n", keymap = "<leader>bb", desc = "Open buffers" },

	-- LSP
	rename = { mode = "n", keymap = "cn", desc = "Rename" },
	lsp_code_actions_1 = { mode = "n", keymap = "<leader>ca", desc = "Code actions" },
	lsp_code_actions_2 = { mode = "n", keymap = "<C-.>", desc = "Code actions" },
	lsp_rename = { mode = "n", keymap = "cn", desc = "Rename" },
	lsp_go_to_definition = { mode = "n", keymap = "gd", desc = "Go to definition" },
	lsp_go_to_references = { mode = "n", keymap = "gr", desc = "Go to references" },
	lsp_go_to_implementation = { mode = "n", keymap = "gi", desc = "Go to implementation" },
	lsp_go_to_type_definition = { mode = "n", keymap = "gt", desc = "Go to type definition" },
	lsp_hover = { mode = "n", keymap = "K", desc = "Hover" },
	lsp_signature_help_i = { mode = "i", keymap = "<C-k>", desc = "Signature help" },
	lsp_signature_help_n = { mode = "n", keymap = "gh", desc = "Signature help" },

	-- Git
	git_status = { mode = "n", keymap = "<leader>gg", desc = "Git status" },
	git_next_hunk = { mode = "n", keymap = "]g", desc = "Next hunk" },
	git_prev_hunk = { mode = "n", keymap = "[g", desc = "Prev hunk" },
	git_reset_hunk = { mode = "n", keymap = "<leader>gr", desc = "Reset hunk" },
	git_reset_buffer = { mode = "n", keymap = "<leader>gR", desc = "Reset buffer" },
	git_diffthis = { mode = "n", keymap = "<leader>gs", desc = "Diff this" },
	git_preview_hunk = { mode = "n", keymap = "<leader>gp", desc = "Preview hunk" },

	-- Toggle
	toggle_spellcheck = { mode = "n", keymap = "<leader>us", desc = "Toggle spellcheck" },
	toggle_diagnostics = { mode = "n", keymap = "<leader>ud", desc = "Toggle diagnostics" },
	toggle_highlight = { mode = "n", keymap = "<leader>uh", desc = "Toggle highlight" },
	toggle_copilot = { mode = "n", keymap = "<leader>uc", desc = "Toggle copilot" },
	toggle_wrap = { mode = "n", keymap = "<leader>uw", desc = "Toggle wrap" },
	toggle_quickfix = { mode = "n", keymap = "<localleader>q", desc = "Toggle quickfix" },

	-- Search and replace
	search_change_goto_next = { mode = { "n", "x" }, keymap = "<leader>cgn", desc = "Search, change and goto next" },

	find_files = { mode = "n", keymap = "<leader>ff", desc = "Find files" },

	previous_entry = { mode = "n", keymap = "<C-p>", desc = "Previous entry" },
	next_entry = { mode = "n", keymap = "<C-n>", desc = "Next entry" },

	fold_bracket = { mode = "n", keymap = "<leader>zf", desc = "Create bracket {} fold" },
	tab_next = { mode = "n", keymap = "<leader>tn", desc = "Next tab" },

	find_recent_files = { mode = "n", keymap = "<leader>fr", desc = "Find recent files" },
	search_resume = { mode = "n", keymap = "<leader>sl", desc = "Search resume" },
	search_jump = { mode = "n", keymap = "<leader>sj", desc = "Search jump to symbol" },
}

local vim_keymap_set = function(keymap, cmd) vim.keymap.set(keymap.mode, keymap.keymap, cmd, { desc = keymap.desc }) end

return {
	vim_keymap_set = vim_keymap_set,
	keymaps = keymaps,
}
