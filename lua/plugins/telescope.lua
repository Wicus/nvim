return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
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
		{
			"jemag/telescope-diff.nvim",
		},
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local live_grep_actions = require("telescope-live-grep-args.actions")

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<Up>"] = actions.cycle_history_prev,
						["<Down>"] = actions.cycle_history_next,
						["<C-f>"] = actions.preview_scrolling_down,
						["<C-b>"] = actions.preview_scrolling_up,
					},
				},
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				path_display = function(opts, path)
					local tail = path
					for i = #path, 1, -1 do
						local char = path:sub(i, i)
						if char == "/" or char == "\\" then
							tail = path:sub(i + 1, -1)
							break
						end
					end
					local relative_path = vim.fn.fnamemodify(path, ":.:h")
					return string.format("%s (%s)", tail, relative_path)
				end,
				tiebreak = function(current_entry, existing_entry, prompt) return existing_entry.index < current_entry.index end,
			},
			extensions = {
				live_grep_args = {
					auto_quoting = true, -- enable/disable auto-quoting
					mappings = {
						i = {
							["<C-k>"] = live_grep_actions.quote_prompt(),
							["<C-i>"] = live_grep_actions.quote_prompt({ postfix = " --no-ignore" }),
							["<C-w>"] = live_grep_actions.quote_prompt({ postfix = " -w" }),
							["<C-g>"] = live_grep_actions.quote_prompt({ postfix = " --iglob" }),
						},
					},
				},
			},
		})
		telescope.load_extension("fzf")
		telescope.load_extension("live_grep_args")
		telescope.load_extension("diff")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>fr", function() builtin.oldfiles({ only_cwd = true }) end, { desc = "[F]ile [R]ecent: Find recently opened files" })
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>bb", builtin.buffers, { desc = "[B]uffers [B]uffers: Find existing buffers" })
		vim.keymap.set("n", "<leader>gg", builtin.git_status, { desc = "Git status" })
		vim.keymap.set("n", "<leader>sl", builtin.resume, { desc = "[S]ession [L]ast (resume telescope)" })
		vim.keymap.set("n", "<leader>sj", builtin.lsp_document_symbols, { desc = "[S]earch [J]ump: Jump to symbol" })
		vim.keymap.set("n", "<leader>ss", builtin.current_buffer_fuzzy_find, { desc = "[S]earch [S]tring: Search in current buffer" })
		-- vim.keymap.set("n", "<leader>fc", function() builtin.find_files({ cwd = vim.uv.cwd() }) end, { desc = "[S]earch [C]onfig: Search configs files" })

		local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
		vim.keymap.set("n", "<leader>/", telescope.extensions.live_grep_args.live_grep_args, { desc = "[/]: Search in project" })
		vim.keymap.set("n", "<leader>*", live_grep_args_shortcuts.grep_word_under_cursor, { desc = "[*]: Search current word in project" })
		vim.keymap.set("v", "<leader>*", live_grep_args_shortcuts.grep_visual_selection, { desc = "[*]: Search selection in project" })

		local search_git_status = require("custom.telescope_search_git_status")
		-- vim.keymap.set("n", "<leader>gg", custom.status, { desc = "Git status" })
		vim.keymap.set("n", "<leader>g/", search_git_status.search_git_status, { desc = "Search git status" })

		vim.keymap.set("n", "<leader>sD", function() telescope.extensions.diff.diff_files({ hidden = true }) end, { desc = "Diff 2 files" })
		vim.keymap.set("n", "<leader>sd", function() telescope.extensions.diff.diff_current({ hidden = true }) end, { desc = "Diff file with current" })
	end,
	cond = function() return not vim.g.vscode end,
}
