return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	main = "ibl",
	opts = {
		indent = { char = "│" },
		scope = { enabled = false },
	},
	cond = function() return not vim.g.vscode end,
}
