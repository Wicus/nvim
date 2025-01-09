return {
	"folke/snacks.nvim",
	lazy = false,
	---@type snacks.Config
	opts = {
		lazygit = { enabled = true },
		input = { enabled = true, icon = "" },
		indent = { enabled = true },
		notifier = {
			icons = {
				error = "",
				warn = "",
				info = "",
				debug = "",
				trace = "",
			},
		},

		---@type table<string, snacks.win.Config>
		styles = {
			input = {
				relative = "cursor",
			},
			scratch = {
				width = 200,
				height = 60,
			},
		},
		picker = {
			ui_select = true, -- replace `vim.ui.select` with the snacks picker
		},
	},
	keys = {
		-- Picker
		{ "<leader>/", function() Snacks.picker.grep() end, desc = "Live grep" },
		{ "<leader>*", function() Snacks.picker.grep_word() end, desc = "Grep cword" },
		{ "<leader>*", function() Snacks.picker.grep_word() end, desc = "Grep visual selection", mode = "x" },
		{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Find recent files" },
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
		{ "<leader>sl", function() Snacks.picker.resume() end, desc = "Resume" },
		{ "<leader>sj", function() Snacks.picker.lsp_symbols() end, desc = "LSP document symbols" },
		{ "<leader>sb", function() Snacks.picker.grep_buffers() end, desc = "Search in buffer" },
		{ "<leader>bb", function() Snacks.picker.buffers() end, desc = "Buffers" },
		{ "<leader>gg", function() Snacks.picker.git_status() end, desc = "Git status" },

		{ "<leader>gl", function() Snacks.lazygit() end, desc = "Lazygit" },
		{ "<leader>.", function() Snacks.scratch() end, desc = "Toggle scratch buffer" },
		{ "<leader>ss", function() Snacks.scratch.select() end, desc = "Select scratch buffer" },
		{
			"<leader>sn",
			function()
				local opts = { name = vim.fn.input("Name: ") }
				if opts.name ~= "" then
					Snacks.scratch.open(opts)
				end
			end,
			desc = "New scratch file",
		},
	},
	config = function(_, opts)
		require("snacks").setup(opts)
		vim.g.snacks_animate = false
	end,
}
