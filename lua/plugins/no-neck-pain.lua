return {
	"shortcuts/no-neck-pain.nvim",
	version = "*",
	opts = {
		width = 180,
		minSideBufferWidth = 41,
		autocmds = {
			enableOnVimEnter = true,
		},
		buffers = {
			right = {
				enabled = false,
			},
			colors = {
				background = "#181825",
			},
			scratchPad = {
				enabled = true,
			},
		},
		mappings = {
			enabled = true,
		},
	},
	cond = function() return not vim.g.vscode end,
}
