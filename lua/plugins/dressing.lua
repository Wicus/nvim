return {
	"stevearc/dressing.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("dressing").setup({
			input = {
				insert_only = true,
				start_in_insert = false,
				title_pos = "center",
				win_options = {
					winblend = 0,
				},
				border = "single",
			},
			select = {
				telescope = require("telescope.themes").get_dropdown({
					borderchars = {
						prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
						results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
						preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					},
				}),
			},
		})
	end,
	cond = function() return not vim.g.vscode end,
}
