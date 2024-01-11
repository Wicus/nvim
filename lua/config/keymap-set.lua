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

	-- Copilot chat
	chat = { mode = { "n", "v" }, keymap = "<leader>cc", desc = "Open chat in buffer" },
	chat_vsplit = { mode = { "n", "v" }, keymap = "<leader>ch", desc = "Open chat in vertical split" },
	chat_quick = { mode = { "n", "v" }, keymap = "<leader>ci", desc = "Quick chat" },
	chat_inline = { mode = { "n", "v" }, keymap = "<leader>cl", desc = "Inline chat" },

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

	-- Commenting
	comment_line_n = { mode = "n", keymap = "gcc", desc = "Comment line" },
	comment_line_v = { mode = "n", keymap = "gc", desc = "Comment line" },

	-- TODO
	find_files = { mode = "n", keymap = "<leader>ff", desc = "Find files" },
	find_recent_files = { mode = "n", keymap = "<leader>fr", desc = "Find recent files" },
	search_resume = { mode = "n", keymap = "<leader>sl", desc = "Search resume" },
	search_jump = { mode = "n", keymap = "<leader>sj", desc = "Search jump to symbol" },
}

local vim_keymap_set = function(keymap, cmd) vim.keymap.set(keymap.mode, keymap.keymap, cmd, { desc = keymap.desc }) end

return {
	vim_keymap_set = vim_keymap_set,
	keymaps = keymaps,
}
