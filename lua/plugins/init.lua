return {
	-- TODO: Check for plugins that take long and lazy load only those
	-- TODO: Check these keys and opts that we are passing, maybe just make it simpler.
	"nvim-lua/plenary.nvim",
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	{ "brenoprata10/nvim-highlight-colors", config = true },
	{ "echasnovski/mini.ai", version = "*", config = true },
	{ "echasnovski/mini.align", config = true },
	{ "echasnovski/mini.pairs", version = "*", config = true, enabled = false },
	{
		"echasnovski/mini.surround",
		opts = {
			mappings = {
				add = "gsa", -- Add surrounding in Normal and Visual modes
				delete = "gsd", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				find_left = "gsF", -- Find surrounding (to the left)
				highlight = "gsh", -- Highlight surrounding
				replace = "gsr", -- Replace surrounding
				update_n_lines = "gsn", -- Update `n_lines`
			},
		},
	},
	{ "echasnovski/mini.trailspace", config = false },
	{ "numToStr/Comment.nvim", event = { "BufReadPre", "BufNewFile" }, config = true },
}
