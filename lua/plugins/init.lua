return {
	-- TODO: Check for plugins that take long and lazy load only those
	-- TODO: Check these keys and opts that we are passing, maybe just make it simpler.
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	"tpope/vim-surround", -- Surround text objects with quotes, brackets, etc
	{ "brenoprata10/nvim-highlight-colors", config = true },
	{ "echasnovski/mini.trailspace", config = false },
	{ "echasnovski/mini.align", config = true },
	{ "numToStr/Comment.nvim", event = { "BufReadPre", "BufNewFile" }, config = true },
}
