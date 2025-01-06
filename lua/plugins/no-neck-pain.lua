return {
	"shortcuts/no-neck-pain.nvim",
	version = "*",
	keys = {
		{ "<leader>n", "<cmd>NoNeckPain<cr>", desc = "NoNeckPain" },
	},
	cmd = "NoNeckPain",
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
			bo = {
				filetype = "md",
			},
		},
		mappings = {
			enabled = false,
		},
	},
}
