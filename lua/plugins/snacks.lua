return {
	"folke/snacks.nvim",
	priotity = 1000,
	lazy = false,
	opts = {
		lazygit = { enabled = true },
	},
	keys = {
		{ "<leader>lg", function() Snacks.lazygit() end, desc = "Lazygit" },
	},
}
