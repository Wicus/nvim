return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			-- if it's linux the the string should just be "make"
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		},
		{
			"nvim-telescope/telescope-live-grep-args.nvim",
			-- This will not install any breaking changes.
			-- For major updates, this must be adjusted manually.
			version = "^1.0.0",
		},
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<Up>"] = actions.cycle_history_prev,
						["<Down>"] = actions.cycle_history_next,
					},
				},
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				path_display = function(opts, path)
					local tail = require("telescope.utils").path_tail(path)
					local relative_path = vim.fn.fnamemodify(path, ":.:h")
					return string.format("%s (%s)", tail, relative_path)
				end,
			},
			pickers = {
				live_grep = {
					mappings = {
						i = { ["<c-f>"] = actions.to_fuzzy_refine },
					},
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("live_grep_args")

		local builtin = require("telescope.builtin")
		local glob_pattern = {
			"!src/shared/dygraphs/**",
			"!src/shared/canvas-gauges/**",
		}

		vim.keymap.set("n", "<leader>fr", function() builtin.oldfiles({ only_cwd = true }) end, { desc = "[F]ile [R]ecent: Find recently opened files" })
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>bb", builtin.buffers, { desc = "[B]uffers [B]uffers: Find existing buffers" })
		vim.keymap.set("n", "<leader>gg", builtin.git_status, { desc = "Git status" })
		vim.keymap.set("n", "<leader>sl", builtin.resume, { desc = "[S]ession [L]ast (resume telescope)" })
		vim.keymap.set("n", "<leader>sj", builtin.lsp_document_symbols, { desc = "[S]earch [J]ump: Jump to symbol" })
		vim.keymap.set("n", "<leader>ss", builtin.current_buffer_fuzzy_find, { desc = "[S]earch [S]tring: Search in current buffer" })
		vim.keymap.set(
			"n",
			"<leader>/",
			function() telescope.extensions.live_grep_args.live_grep_args({ glob_pattern = glob_pattern, additional_args = { "--fixed-strings" } }) end,
			{ desc = "[/]: Search in project" }
		)
		vim.keymap.set(
			"n",
			"<leader>*",
			function() builtin.grep_string({ glob_pattern = glob_pattern, word_match = "-w" }) end,
			{ desc = "[*]: Search current word in project (Case Sensitive)" }
		)
		vim.keymap.set("v", "<leader>*", function()
			builtin.live_grep({
				default_text = (function()
					vim.cmd('normal "vy')
					return vim.fn.getreg("v") or ""
				end)(),
				glob_pattern = glob_pattern,
				additional_args = { "--case-sensitive", "--fixed-strings", "--word-regexp" },
			})
		end, { desc = "[*]: Search current word in project (Case Sensitive) (Word Boundary)" })
	end,
	cond = function() return not vim.g.vscode end,
}
