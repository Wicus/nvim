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
				row = -3,
				col = 0,
			},
		},
	},
	keys = {
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
