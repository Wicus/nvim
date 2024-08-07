return {
	"shortcuts/no-neck-pain.nvim",
	version = "1.6.3",
	opts = {
		width = 180,
		autocmds = {
			enableOnVimEnter = true,
		},
		buffers = {
			right = {
				enabled = false,
			},
			colors = {
				blend = -0.2,
			},
			scratchPad = {
				enabled = false,
			},
		},
		mappings = {
			enabled = true,
		},
	},
	cond = function() return not vim.g.vscode end,
}
